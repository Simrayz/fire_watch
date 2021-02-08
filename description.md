# Firedatabase

## Description

A company with the name FireWatch A/S have been collecting data on forest fires since 2007. They now want to offer up a user interface in which their employees can use and present the data in a clear way to each other and to their customers. The interface must be accesible via any browser and should be web-based. Aside from that, the choice of technology and presentation tools is your choice. However, they don't want all data to be displayed. The fields that are relevant for this application from the file **[forestdata.csv](./forestfires.csv)** are column numbers, and is as described in **[forestfires.names](https://github.com/Ur-Solutions/interview-cases/blob/c09760e29caec1459114b2ffec6f90c3eae4b9c9/FireWatch/forestfires.names#L46)**:

3. month - month of the year: "jan" to "dec"
4. day - day of the week: "mon" to "sun"
9. temp - temperature in Celsius degrees: 2.2 to 33.30
10. RH - relative humidity in %: 15.0 to 100
11. wind - wind speed in km/h: 0.40 to 9.40
12. rain - outside rain in mm/m2 : 0.0 to 6.4
13. area - the burned area of the forest (in ha): 0.00 to 1090.84

## Solution

Your solution should satisfy the following requirements:

- It should be possible to add new data
- The data should be stored persistently
- The data should be available via an end user application
- The data should be presented in a clear way to the end user

## Deliveries

The following should be delivered:

- An invitation / access to a GitHub repository (we ask that you commit your code frequently)
- A clear README in the repository with the following contents:
  - How should the application be used?
  - A short description of the technologies used
  - What problems does the application solve?
  - How do you build the application?
  - How do you run the application?

## What are we looking for

- You do not need to create a full solution!
- Something that runs well is more important than how it looks (but do whatever you feel you have time to do!)
- An explanation of the choices that you have made in the process, and what technologies you have used to create the solutions.

## Attachements

- **[forestdata.csv](./forestfires.csv):** the forest-fire data
- **[forestfires.names](./forestfires.names):** a description of the dataset
