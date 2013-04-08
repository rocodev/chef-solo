god-apps Cookbook
=================

Manage and enable applications god config file.

Requirements
------------

#### platforms

* Ubuntu 12.10

#### cookbooks

- `god` - Require god cookbook to enable application god monitor.

Attributes
----------

#### god-apps::default

* `god[:applications]` - Specify server god monitor applications

```ruby
:god => {
  :applications => ["memcached"]
}
```

Usage
-----

#### god-apps::default

Include `god-apps` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[god-apps]"
  ]
}
```
