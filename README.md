# csv2.cr [![Build Status](https://travis-ci.org/maiha/csv2.cr.svg?branch=master)](https://travis-ci.org/maiha/csv2.cr)

A monkey patch for `CSV`(stdlib) to provide `quote_always` in CSV.build.
Since this is a temporary repository before creating PR, we simply name `CSV2`.

- crystal: 0.26.1

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  csv2:
    github: maiha/csv2.cr
    version: 0.1.0
```

## Usage

#### `CSV`(stdlib)

```crystal
CSV.build do |csv|
  csv.row do |row|
    row << 1
    row << "doesn't"
  end
end
```

```
1,doesn't
```

#### `CSV2`

```crystal
CSV2.build(quote_always: true) do |csv|
  csv.row do |row|
    row << 1
    row << "doesn't"
  end
end
```

```
"1","doesn't"
```

## Contributing

1. Fork it (<https://github.com/maiha/csv2.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
