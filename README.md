# Heroku Link
https://task-list-thjn.herokuapp.com/

# Task List
We are going to use our new found knowledge of databases and web development to create a task list, powered by Sinatra and SQLite. This project will enable us to persist tasks for a to-do list by adding, listing, and optionally editing and deleting them.

## Baseline Setup
This project has the "normal" Git setup which requires you to create a branch on our project master as well as creating your own fork.
You'll be working on this assignment in pairs.  
- Group Member 1: Clone the **Project Master** repo into your `project-masters` directory.  
- Group Member 1: Create and push your branch (from your combined initials) to **Project Master**.  
- Group Member 1: Fork the **Project Master** to your GitHub account.  
- Both Group Members: Clone the fork from the previous step into your `project-forks`.  
- Both Group Members: Switch to the branch you created above.  

## Baseline Requirements
**Work together to accomplish this baseline:**

For the baseline you will need to create the following project files:
- A Gemfile with all of the gems necessary for Sinatra, SQLite, and anything else you want to use (Pry, RSpec, etc).
- A Sinatra class for your routes, and a root route to start. This route does not need to render any ERB template yet.
- A config.ru file that runs your Sinatra class; look at the structure in the SinatraSite project for an example.

Additionally you will need to do the following to design and create your database:
- Create a database schema suitable for storing and organizing "tasks". Design this on paper or in a text editor first, and then translate it into SQL code using `CREATE TABLE`. Put this code in the `lib/database.rb` file, within the `create_schema` method.
- Write a database setup script, `create_schema.rb`, that creates the table(s) defined in your schema.

When you are done with the baseline it should be possible to setup your project on a different computer using the following bash commands:
```bash
$ git clone <SSH URL>
$ cd TaskListSinatra
$ bundle install
$ ruby create_schema.rb
$ bundle exec rackup
```

## Primary Requirements
- Use a class that will keep track of the low-level database interaction. The responsibility of this class is to create a database connection and also to create the database schema. This class exists already in `lib/database.rb`.

- Create a class that will inherit behavior from the database interaction class that will be responsible for all of the **task** record (row) persistence. This will include inserting new tasks into the database, and selecting existing tasks from the database.

  Each task record will include all of the following. Optional means that the _user_ may choose not to provide this information, but it is still required for your schema:
    - Self-incrementing identifier
    - Name (required)
    - Description (optional)
    - Completed date (optional)

- The home page (root route) of your Sinatra site should show the list of all of the tasks currently in the database.

- Be able to create a new task:
  - The home page should contain a link to Add a new task. This will give the user a form to fill out with the appropriate task fields.
  - After the new task is added, the site should take the user back to the home page which displays the full list of tasks. The new task that was just added should be included in the full list of tasks.

## Optional Requirements 
- Add the ability for the user to mark a task complete
  - Update the list of tasks on the home page to indicate which tasks are complete
  - Update the database interaction class to update a task's completed date
  - Use a form with checkboxes or radio buttons to allow a user to mark a task complete

- Add the ability for the user to delete an existing task, whether it is complete or not
  - Update the list of tasks on the home page to include a delete link
  - Before the system deletes the task, ask the user for confirmation
  - Update your database interaction class to delete from the database

- Add the ability for the user to edit the task
  - Re-use the form that was used for the Add task functionality
  - Update the list of tasks on the home page to include an edit link for each task
  - This includes updating your database interaction class to update the database
