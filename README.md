# decloak

Unix command that decloaks an HTTP Authorization header.

- Reads an HTTP Authorize header as an argument or from standard in
- Decodes and prints the user and password
- If a Bearer token is used instead of Basic auth, the JWT is decoded
  and the header and payload is pretty printed
- The `exp` and `iat` timestamp fields are converted to human dates.

## Example usage

```perl
$ echo 'Authorization: Basic Zm9vOmJhcg==' | decloak
foo:bar
```

Here, thers's [Bearer]() token instead of [Basic]() authenticated. You
may omit the `Authorization: Beaer` if you want, so `decloak` can be
used to decloak _any_ JWT:

```
$ decloak eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb19pZCI6IjMxYzliNV9mNjJkZmMwNDJhOTg0YjdlYjI3ZTk3NjhlYmI0NzMzOCIsImlzX2NsaXAiOmZhbHNlLCJpYXQiOjE3MzMxNDQ0MDAsImV4cCI6MTczMzIzMDgwMCwiaXNzIjoiYXBwOnZvZCIsInN1YiI6InVzZXI6dm9kIn0.E3N_r6eX46S7vKxCQHQQ2b4Zcw2rt0fNs_AlUCCLZkQ 
```
```json
{
  "header": {
    "alg": "HS256",
    "typ": "JWT"
  },
  "body": {
    "video_id": "31c23_f62df34234adfs",
    "is_clip": false,
    "iat": 1733144400,
    "exp": 1733230800,
    "iss": "app:vod",
    "sub": "user:vod"
  },
  "iat": "Mon Dec  2 14:00:00 CET 2024",
  "exp": "Tue Dec  3 14:00:00 CET 2024"
}
```
