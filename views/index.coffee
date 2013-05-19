h1 -> @title
p -> "Welcome to #{@title}"
form action: '/gen', method: 'POST', ->
  textarea name: 'text', ->
  input type: 'submit', value: 'submit', ->
