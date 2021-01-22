# dotenv-filler
A simple environment-to-file script. Match-and-replace values of key-value pairs in a file directly from your environment. Can be used for example in CI pipelines to generate .env files from their example equivalents.

## What it does
The script goes through every key in a given key-value file. If a key has a value in the environment, the script replaces its value with the one from the environment.
You can also provide a prefix to help keeping your variables separate.

## Requirements
- POSIX compatible shell
- [sed](https://en.wikipedia.org/wiki/Sed) utility
- [env](https://en.wikipedia.org/wiki/Env) utility

## Usage
```
sh dotenv-filler.sh FILE [VAR_PREFIX]
```
Parameters:
- `FILE` The key-value file to apply changes to
- `VAR_PREFIX` - Look for the variables with this prefix in the environment.

### Examples
Let's take a file named `.env` with the following content:
```
FIRST_VARIABLE=
SECOND_VARIABLE=255
```
#### Without using a prefix:
Running `FIRST_VARIABLE=test sh dotenv-filler.sh .env` will change the contents of the file to the following:
```
FIRST_VARIABLE=test
SECOND_VARIABLE=255
```
#### Using a prefix:
Running `PRE_SECOND_VARIABLE=hello sh dotenv-filler.sh .env PRE` will change the contents of the file to the following:
```
FIRST_VARIABLE=
SECOND_VARIABLE=hello
```
