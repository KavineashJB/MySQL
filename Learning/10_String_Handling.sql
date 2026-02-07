desc customers;

SELECT * from customers;

-- methods
-- length
-- concat(str1,str2,...)
-- substring(str, pos, length) => pos from 1
-- substring_index(str,delimeter,1=before/-1=after) => for splitting string
-- trim( str ), ltrim(str ), rtrim( str)
-- lpad(str,length,'filler'), rpad() => also remove other chars than length (see in example)
-- replace(col, 'old_char', 'new_char') => regex is on upper level of replace
-- instr(col,'char') => to get the position of char => returns 0 if not found
-- left(str,length) => get str with length of str reads from starting of str(0)
-- right(str,length) => get str with length of str reads from end of str(n)
-- reverse(str)
-- format(decimal,precision) => returns formatted to specified no.of decimal places as comma separated(especially for price)
-- ** we can also use function inside another function like length(upper(concat(str1,str2,..))) as str_len
-- substring_index(str, deli, count) => split string
-- Eg:
-- SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('A,B,C,D', ',', 3),',',-1);   -- OP: C


-- select substring of name with 5 chars + '...' as suffix
select name, 
case 
    when length(name)>=5 then concat(SUBSTRING(name,1,5),'...') else name
end as updated_name,
upper(name),
lower(city),
concat(name, ' - ', city) from customers;

select lpad(city,2,'*'), rpad(city,10,'*'), replace(name,' ','_'), instr(name, 'a'), instr(name, 'z') from customers;
 

-- select first char of first and last name
select name, concat(left(substring_index(name,' ',1),1),left(substring_index(name,' ',-1),1)) from customers;

select name, reverse(name), amount, format(amount, 2) from customers;