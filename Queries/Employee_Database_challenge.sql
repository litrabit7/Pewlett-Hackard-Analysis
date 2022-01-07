-- create eligible retirement employee table with job title 
select e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
into retirement_titles
from employees as e
inner join titles as t
on (e.emp_no = t.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;

--retrieve unique employee record with latest title 
-- Use Dictinct with Orderby to remove duplicate rows
select distinct on (emp_no) emp_no, 
	first_name,
	last_name,
	title
into unique_titles
from retirement_titles 
order by emp_no, to_date desc; 

--count # of unique job titles from unique title table
select count (distinct title) from unique_titles;

--retrieve # of employee retireing from each title 
-- in decending order by total
select count (emp_no), title
into retiring_titles
from unique_titles
group by title
order by count (emp_no) desc;