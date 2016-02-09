# Triptastic

An Ecto 2.0 sample application that compares naive filtering and window queries.

## Installation

Clone the repository and then follow these `mix` steps:

```bash
mix deps.get, ecto.create, ecto.migrate
```

Now you're ready to run the tests:

```bash
mix test
```

## Results

Initial results in table form:

```
| trips | memory  | window |
| ----- | ------- | ------ |
| 100   | 2.464   | 2.129  |
| 500   | 22.088  | 3.479  |
| 5000  | 34.62   | 19.747 |
| 10000 | 69.435  | 38.229 |
| 20000 | 147.987 | 76.326 |
```

## License

MIT License, Copyright (c) 2016 Parker Selbert
