select * from followup;

-- Find out the number of unique job requisition.
select count(distinct code) as 'unique requisition'
from followup;

-- Find out the number of unique job Position.

select count(distinct Position) as 'unique requisition'
from followup;

-- Find out the number of Unique Candidates.

select count(distinct Student_Name) as 'unique requisition'
from followup;

-- Find out the number, name and position of Shorlisted Candidates against per requisiton.
select Code ,Student_Name ,position , count(*) as 'Requisition count'  from followup 
group by Code , Student_Name, position
order by count(*) desc; 

-- Find out the number of Shorlisted Candidates against per requisiton.
select Code, count(*) as 'Requisition count'  from followup 
group by Code 
order by count(*) desc; 

-- Find out the number of Shorlisted Candidates Based on their name.

select Student_Name, count(*) as 'Requisition count'  from followup 
group by Student_Name 
order by count(*) desc; 

-- Department Wise requisition work number.
select Department, count(*) as 'Requisition count'  from followup 
group by Department 
order by count(*) desc; 

-- Organization Wise requisition work number.
select Organization_Name, count(*) as 'Requisition count'  from followup 
group by Organization_Name 
order by count(*) desc;

-- Call Status Overview.
select Call_Status, count(*) as 'Requisition count'  from followup 
group by Call_Status 
order by count(*) desc;

-- Call Ratio.
select
(select count(*) from followup where Call_Status = 'Received')/ 135 * 100  as 'Received Ratio',
(select count(*) from followup where Call_Status = 'N/R')/ 135 * 100  as 'N/R Ratio',
(select count(*) from followup where Call_Status = 'Phone Off')/ 135* 100 as 'Phone Off Ratio' ;

-- Database from Received call students.

select * from followup 
where Call_Status = 'Received';

-- Status of Interview attend decision of candidates from received.

select Interview_attend_decision,count(*) as 'Number Count' from
followup 
where Call_Status = 'Received'
group by Interview_attend_decision;

--  % Status of Interview attend decision of candidates from received.

select Interview_attend_decision,concat(count(*) / 129 * 100,'%') as 'Number Count' from
followup 
where Call_Status = 'Received'
group by Interview_attend_decision;

-- N/I reasons regarding interview attend.

select Reason_for_Not_Interested from followup
where Call_Status = 'Received'
and Interview_attend_decision = 'Not Interested';

-- Status of N/I reasons regarding interview attend

select Reason_for_Not_Interested,count(*) from followup
Where Interview_attend_decision = 'Not Interested'
group by Reason_for_Not_Interested;

-- Top 5 placement dates.
select CV_send_Date, Organization_Name, count(*) as 'Date Count'
from followup
where CV_send_Date <> ""
group by CV_send_Date , Organization_Name
order by count(*) desc
limit 5;

-- Lowest 5 placement dates.
select CV_send_Date, Organization_Name, count(*) as 'Date Count'
from followup
where CV_send_Date <> ""
group by CV_send_Date , Organization_Name
order by count(*)
limit 5;

-- Porfolio Quality Status.

select CV_Quality_Portfolio_Feedback_from_Employer, 
count(*) from followup
where Interview_attend_decision = 'Interested'
and CV_Quality_Portfolio_Feedback_from_Employer <> 'N/A'
group by CV_Quality_Portfolio_Feedback_from_Employer
order by count(*) desc;

-- CV view number. 

select count(*) as 'CV View Number' from followup
where Interview_attend_decision = 'Interested' and
CV_Quality_Portfolio_Feedback_from_Employer 
not in ('N/A','CV skipped');

-- CV view Ratio. 

select concat(count(*)/107 *100,'%') as 'CV View Number' from followup
where Interview_attend_decision = 'Interested' and
CV_Quality_Portfolio_Feedback_from_Employer 
not in ('N/A','CV skipped' );

-- Interview Attend Status.
select Interview_Attend,count(*) from followup
group by
Interview_Attend;

-- Interview attend ratio against job placement.
select concat(count(*) / 119 *100 , '%') as 'Interview atted Ratio'
from followup 
where Interview_Attend = 'Yes';


-- Interview attend ratio against CV View.
select concat(count(*) / 76 *100 , '%') as 'Interview atted Ratio'
from followup 
where Interview_Attend = 'Yes';

-- Interview Performanc Status.

select Interview_Performance,count(*) as 'Performance Count' from followup
where Interview_Attend = 'Yes'
group by Interview_Performance
having Interview_Performance <> 'N/A'
order by count(*) desc;

-- remarks for low performance.
select Remarks_of_Poor_Performance,count(*) from followup
where Interview_Performance = 'Low'
group by Remarks_of_Poor_Performance
having Remarks_of_Poor_Performance <> 'N/A';

-- Decision from company.
select Decision_from_Company, count(*) from
followup
where Interview_Attend = 'Yes'
group by Decision_from_Company
having Decision_from_Company <> "" 
and Decision_from_Company <> 'N/A'
order by count(*) desc;

-- Job Confirmation Ratio.

select(

concat(
(select count(*) from followup
where
Decision_from_Company in ('hired', 'Job Offer'))
/
(select count(*) from followup
where Interview_Attend = 'Yes' ) *100, '%')
)
as 'Job confirmation Ratio';
