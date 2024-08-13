# Functional Core, Imperative Shell
The idea of this is to build up to a more Core/Shell paradigm for a web
application, but I was getting too caught up in web stuff; so going to do the
same with rudimentary puts calls acting as the shell, maybe eventually a CLI
app, and then extend out from there.

* 2024-07-29 Update to plan:
- I'm going to move to using a CLI, because without user interaction, there are really no side-effects at all to worry about, and I can't test my 'unknown', because a TODO list is literally just an array.

## Features
(Modified from TODO MVC)

No todos
[x] When there are no todos - the only action is to add a todo

Mark all as complete - marks all todos complete

Item
A todo item has three possible interactions:

[x] - complete one todo
[ ] - edit one todo
[ ] - remove todo
[ ] - update todo

[x] Counter
Displays the number of active todos in a pluralized form.

[x] Clear completed button
Removes completed todos when clicked. Should be hidden when there are no completed todos.

Persistence:
* Markdown for the CLI app
