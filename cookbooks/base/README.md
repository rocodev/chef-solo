base Cookbook
=============

Install useful or required system utilities on servers. And manage server related system config.

Requirements
------------

#### platforms

* Ubuntu 12.10

Attributes
----------

#### base::default

* `base[:packages]` - Install extra packages on server.

```ruby
:base => {
  :packages => ["wget", "tmux"]
}
```

Usage
-----

#### base::default

Include `base` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[base]"
  ]
}
```
