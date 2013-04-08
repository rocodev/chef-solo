users Cookbook
==============

Manage users account, ssh authorized_keys and sudo authority.

Requirements
------------

#### platforms

* Ubuntu 12.10

Usage
-----

#### users::default

Include `users` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[users]"
  ]
}
```
