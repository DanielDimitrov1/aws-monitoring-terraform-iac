#!/bin/bash

default_authentication() {
  echo "Using default authentication with AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY."
  AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?'AWS_ACCESS_KEY_ID variable missing.'}
  AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?'AWS_SECRET_ACCESS_KEY variable missing.'}
}

oidc_authentication() {
  echo "Authenticating with an OpenID Connect (OIDC) Web Identity Provider."
  mkdir -p /.aws-oidc
  AWS_WEB_IDENTITY_TOKEN_FILE=/.aws-oidc/web_identity_token
  echo "${BITBUCKET_STEP_OIDC_TOKEN}" >> ${AWS_WEB_IDENTITY_TOKEN_FILE}
  chmod 400 ${AWS_WEB_IDENTITY_TOKEN_FILE}
  aws configure set web_identity_token_file ${AWS_WEB_IDENTITY_TOKEN_FILE}
  aws configure set role_arn ${AWS_OIDC_ROLE_ARN}

  mkdir -p ~/.aws
  cat <<EOF > ~/.aws/config
[profile $ENV]
role_arn = ${AWS_OIDC_ROLE_ARN}
web_identity_token_file = ${AWS_WEB_IDENTITY_TOKEN_FILE}
region = ${AWS_DEFAULT_REGION}
EOF

  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
}

sts_authentication() {
  echo "Authenticating with STS role."
  mkdir -p /.aws-sts
  AWS_STS_CREDENTIALS_FILE=/.aws-sts/credentials
  aws sts assume-role --role-arn ${AWS_ROLE_ARN} --role-session-name ${AWS_ROLE_SESSION_NAME} > ${AWS_STS_CREDENTIALS_FILE}
  chmod 400 ${AWS_STS_CREDENTIALS_FILE}
  AWS_ACCESS_KEY_ID=$(cat ${AWS_STS_CREDENTIALS_FILE} | jq -r '.Credentials.AccessKeyId')
  AWS_SECRET_ACCESS_KEY=$(cat ${AWS_STS_CREDENTIALS_FILE} | jq -r '.Credentials.SecretAccessKey')
  AWS_SESSION_TOKEN=$(cat ${AWS_STS_CREDENTIALS_FILE} | jq -r '.Credentials.SessionToken')
  export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
  export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
  export AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
}

setup_authentication() {

  AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:?'AWS_DEFAULT_REGION variable missing.'}
  AWS_OIDC_ROLE_ARN=${1:?'OIDC role ARN argument missing.'}

  if [[ -n "${AWS_OIDC_ROLE_ARN}" ]]; then
    if [[ -n "${BITBUCKET_STEP_OIDC_TOKEN}" ]]; then
      oidc_authentication
    else
      echo "Parameter 'oide: true' in the step configuration is required for OIDC authentication"
      default_authentication
    fi
  elif [[ -n "${AWS_ROLE_ARN}" ]]; then
    sts_authentication
  else
    default_authentication
  fi

  # Export variables to AWS credentials file as default profile#
  mkdir -p ~/.aws
  cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
aws_session_token = ${AWS_SESSION_TOKEN}
EOF
}
# Call setup_authentication with the OIDC role ARN as an argument
setup_authentication $1