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
| trips | memory  | window | joined |
| ----- | ------- | ------ | ------ |
| 100   | 3.045   | 2.359  | 4.471  |
| 500   | 5.423   | 3.675  | 5.745  |
| 5000  | 29.415  | 18.54  | 20.078 |
| 10000 | 80.476  | 35.776 | 42.852 |
| 20000 | 144.125 | 76.347 | 77.836 |
```

## License

MIT License, Copyright (c) 2016 Parker Selbert
