# ip_alloc

Things you may want to cover:

* Ruby version : 2.3.0

* Rails version : 4.2.7.1

* System dependencies : Bundler version 1.12.5

* Configuration :

* Database creation : N/A

* How to run the test suite : $ rspec

* Services : {host}/devices/1.2.3.5 and {host}/devices/assign


## Run Application Locally

You don't need to do any configuration just make sure that `IPALLOC_DATAPATH` environment variable is set with data file path

Exact the zip file and go to the root of the project.

Run the bundle command to install all the gem dependencies.

```console
$ bundle install
```

Next, you need to run the rails server:

$ rails server -p 8080

## APIs

### /devices/{address}

GET
{host}/devices/{ip}

Response:

- If record found

Status code : 200

```ruby
{
  "error": "NotFound",
  "ip": "1.2.3.4"
}
```

- If record not found

Status code : 404

```ruby
{
  "error": "NotFound",
  "ip": "1.2.3.4"
}
```


### /addresses/assign

POST
{host}/devices/assign

Request Body:

```ruby
  {"ip":"1.2.3.4", "device":"device1"}
```

Response:
Status code: 201
```ruby
{
  "ip": "1.2.3.1",
  "device": "device1"
}
```

In case of bad request:
Request:

```ruby
  {"ip":"1.2.256.1", "device":"device1"}
```

Response:
Status code: 400
```ruby
{
  "error": "Invalid IPv4",
  "ip": "1.2.256.1"
}

```