#  Execercises (Elmoin Meetup July 2016)

Let's have some fun talking Elm to Javascript, and vice versa.

## Exercises

### Helpful links
- [JavaScript and Ports · An Introduction to Elm ](http://guide.elm-lang.org/interop/javascript.html)
- [Moment.js Documentation](http://momentjs.com/docs/)

### Installation

- Fork https://github.com/elmoin/port-exercise.git

- Run

```
git clone https://github.com/elmoin/port-exercise.git {your-project}
cd {your-project}
npm i
elm package install -y
npm start
```

- Open [http://localhost:3333](http://localhost:3333) in your browser to to see your result immediately while coding with your editor.

- Finally open a pull request to show your results.

### Exercise 1
- Use [momentjs](http://momentjs.com) to count how many days we already have had this year from today.
- _Hint:_ Use "difference" http://momentjs.com/docs/#/displaying/difference/

### Exercise 2
- Create two input fields to enter two different dates.
- Use [momentjs](http://momentjs.com) to determine how many years, months and days are between these two dates?
- Example data:
```
Date 1: 01/01/2010
Date 2: 13/07/2016
Result: 6 years, 7 months, 13 days
```
- _Hint:_ For an example of an input implementation check [Todo.elm](https://github.com/evancz/elm-todomvc/blob/master/Todo.elm#L212-L221) of Elm TodoMVC app.

### Exercise 3
- Extend the basic example to get a random number from JS right after the initialization of the application without clicking the button "Get random from JS!"
- _Hint:_ Check out "[Sending data to a port immediately after initialization](https://groups.google.com/forum/#!topic/elm-discuss/kFQV7Lg5-9I)"

## License

[MIT](./LICENSE)


## Have fun :)
