# FireWatch
## How to use
The application contains two pages, a dashboard and a fire report browsing overview.

### Dashboard
Shows a simple overview the forest fire data in the database.
1. The total amount of reports in the database.
2. An overview of the months with most reported fires.
3. An overview of relevant resources (to the code, not the dataset)
4. A table showcasing the latest updates. 

All information in the dashboard is updated in real-time if any fire report is added, updated or deleted.

### Reports
Lets you browse all the fire reports in the database, as well as add new reports, edit or delete existing reports.

The data is presented in a paginated table, with the following options:
1. Select how many rows to show per page.
2. Clicking on a column header will sort the data by that column (default mode is descending). Clicking it again will toggle ascending mode.
3. Create a new report by clicking `New Fire Report`. The form is validated and will notify on errors.
4. Edit an existing report by clicking `Edit` on the corresponding row. Delete a report in the same manner by clicking `Delete`.

## Technology used
* The project was developed using [Elixir](https://elixir-lang.org/) and the [Phoenix Framework](https://www.phoenixframework.org/). 
* [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html) was used for interactive client interaction and live updates. 
* [Tailwind CSS](https://tailwindcss.com/) was used for styling.

## What problems does the application solve?
The application allows for effective browsing of forest fire reports, as well as creating, updating and deleting said reports. 

* The `Reports` page allows for sorting and paginating data, by every column and selectable amounts of data per page. 

* The `Dashboard` shows information that is updated in real-time, allowing for a quick overview of the data, as well as quick reaction times for FireWatch A/S.

* The `Fire Report Form` is validated in real-time to make sure that employees are entering data in the allowed ranges.

## Building the application
I have prepared two options for installing and running application. The first requires installation of phoenix/elixir locally, while the other uses docker-compose to get you started quicker.

### Manual method

### Installing required software
1. Install `elixir` and `erlang`. The [official elixir installation guide](https://elixir-lang.org/install.html) should explain how to do this on most platforms.
2. If you don't have `PostgreSQL` and `NPM` installed, make sure you do before continuing. The [phoenix installation guide](https://hexdocs.pm/phoenix/installation.html) contains instructions for this.
3. You don't need it to run the application, but installing `Phoenix` using the [official installation guide](https://hexdocs.pm/phoenix/installation.html) is an option. 

### Starting the application
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Docker method
> Warning: When using docker, I noticed significant delay when navigating between pages, so I recommend the `Manual method` for maximum performance. However, the docker method works as intended otherwise.

1. If you have postgres installed locally, make sure to turn off the database server as to not cause port conflicts.
1. Run `docker-compose build`
2. Run `docker-compose run web mix ecto.setup`. <br/>
  This step will take some time, as the application will compile. The command creates the database, runs migrations, and seeds initial data (from `forestfires.csv`).
3. Run `docker-compose up`<br/>
  This step should start the application if everything went correctly. 

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more about Phoenix

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
