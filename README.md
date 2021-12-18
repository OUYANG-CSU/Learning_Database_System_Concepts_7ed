# Learning_Database_System_Concepts_7ed
using the database Oracle for this book,and some ".sql" files

you can visit the webiste for more details:

https://www.db-book.com/university-lab-dir/sqljs.html

when you first run the college.sql,there may be some error reports: xxx table is not exits;

you can just comment the first statement in college.sql which is @/home/oralce/Oralce_WLC/drop_all_table.sql;

i have to admit that the design of the tables is very excellent.especially for some table's foreign key ... on delete set null OR ....on delete cascade;
then you can't drop a table arbitrarily.

so i write down the drop_all_table.sql for we can drop all table in the correct order.
