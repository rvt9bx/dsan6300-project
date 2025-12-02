# DSAN 6300 Mini-Project: Thanksgiving Travel 2024

Welcome to the repository for my DSAN 6300 Database Systems and SQL mini-project analyzing **Thanksgiving travel in 2024**. This project uses flight data from November 2024, supplemented with airport location and TSA checkpoint data to explore patterns in flight volumes, delays, and cancellations during the holiday period.

The live project website can be accessed here: [Thanksgiving Travel 2024](https://rvt9bx.github.io/dsan6300-project/)

---

## Project Overview

This project involved:

- Collecting flight data for November 2024 from the U.S. DOT On-Time Performance dataset and complementary dimension tables.
- Creating a MySQL schema in AWS RDS, loaded large fact tables via mysqlimport from an AWS EC2 instance, and managing dimension tables in MySQL Workbench.
- Writing queries to identify maximum delays, early departures, busiest days, high-delay airports, cancellation patterns, and rolling averages of flights.
- Building an interactive Quarto website with Python Plotly visualizations to communicate trends in flight volumes, delays, and cancellations.
- Publishing the website via GitHub Pages, to tell a data-driven story about air travel during the Thanksgiving holiday period.

---

## Data Sources

- [Bureau of Transportation Statistics – Carrier On-Time Performance Data](https://www.transtats.bts.gov/Fields.asp?gnoyr_VQ=FGJ)
- [Bureau of Transportation Statistics – Master Coordinate Data](https://www.transtats.bts.gov/Fields.asp?gnoyr_VQ=FLL)
- [TSA Passenger Volumes Data](https://www.tsa.gov/travel/passenger-volumes/2024)
- Assorted dimension tables 

---

## Project Structure

This repo contains several folders: data/, scripts/, and website/, as well as this README.md and a .gitignore file. 

The data/ folder contains:
- the dimension tables downloaded for the airline performance database
- the resulting output from each sql query, used in the visualizations
- supplementary airport geographic data
- a readme data dictionary for the "al_perf" dataset downloaded from the BoTS (too large for GitHub) 

The scripts/ folder contains:
- the script used to initialize the al_perf fact table in MySQL
- the script containing my SQL queries 

The website/ folder contains:
- .quarto/
- docs/ folder with the rendered website HTML
- quarto project configuration YAML
- index.qmd as the website home page 
- a bibliography for the website
- styles.css

---


