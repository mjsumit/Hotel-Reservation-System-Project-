Hotel Reservation System - SQL Analysis
A comprehensive database project designed to manage and analyze hotel operations, including room availability, customer bookings, and revenue tracking.

📌 Project Overview
This project demonstrates the design and implementation of a relational database for a hotel chain. It covers the entire data lifecycle from Schema Design and Data Insertion to complex Analytical Querying.

🛠️ Tech Stack
Database: MySQL / PostgreSQL

Language: SQL

Concepts: Data Modeling, Joins, Aggregate Functions, Subqueries, and CRUD operations.

📊 Database Schema
The system is built on five interconnected tables:

hotel: Stores hotel details and ratings.

room: Tracks room types, pricing, and availability.

customer: Manages guest information.

reservation: Records booking durations and statuses.

payment: Handles transaction records and payment methods.

🚀 Key Business Insights Extracted
I used SQL queries to solve real-world business questions, such as:

Revenue Analysis: Calculated total revenue across all hotels using SUM() functions.

Operational Efficiency: Identified currently available rooms to optimize occupancy.

Customer Behavior: Analyzed booking patterns and filtered high-value customers who booked multiple times.

Financial Auditing: Used LEFT JOIN to identify unpaid reservations for follow-up.

Competitive Pricing: Determined average room prices and identified the most expensive luxury suites using subqueries.

📂 How to Use
Clone the repository.

Import the Sumit SQL Project.sql file into your SQL environment.

Run the queries to see the data analysis in action.
