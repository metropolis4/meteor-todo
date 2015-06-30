Tasks = new Mongo.Collection "tasks"

if Meteor.isClient
  Template.body.helpers
    tasks: ->
      Tasks.find({},
        sort:
          createdAt: -1)

  Template.body.events
    "submit .new-task": (event) ->
      console.log event.target.text.value
      text = event.target.text.value
      Tasks.insert
        text: text
        createdAt: new Date()

      event.target.text.value = ""
      false

  Template.task.events
    "click .toggle-checked": ->
      Tasks.update @_id,
        $set:
          checked: ! @checked
    "click .delete": ->
      Tasks.remove @_id
