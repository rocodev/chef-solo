projects Cookbook
=================

Manage and enable or disable project nginx config on server.

Requirements
------------

#### platforms

* Ubuntu 12.10

#### cookbooks

- `nginx` - Require nginx cookbook to enable or disable project nginx config.

Attributes
----------

#### projects::default

* `projects` - Specify project nginx config file name and enable or not.

```ruby
:projects => [
  { :name => "project01" :enabled => true  },
  { :name => "project02" :enabled => false }
]
```

Usage
-----

#### projects::default

Just include `projects` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[projects]"
  ]
}
```
