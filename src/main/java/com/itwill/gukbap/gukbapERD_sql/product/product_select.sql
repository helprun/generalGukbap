
--모든 제품 불러오기
select * from product;

--제품명으로 제품 하나 불러오기 
select * from product where product_name='굴국밥';

--(제품 번호 있으면) 제품 하나 불러오기
select * from product where product_no=21;
-
--(카테고리 번호 있으면) 국밥류만 불러오기
select * from product where category_no=1;

--(카테고리 번호 있으면) 사이드만 불러오기
select * from product where category_no=2;

--(카테고리 번호 있으면) 음료 및 주류만 불러오기
select * from product where category_no=3;

--(카네고리 번호 있으면) 가격이 높은 순서대로, 
--가격이 낮은 순서대로, 
--주문량이 많은 순서대로, 
--주문량이 적은 순서대로, 
--클릭수가 많은 순서대로, 
--클릭수가 적은 순서대로, 
--세일하고 있는 국밥류만 불러오기


--(카네고리 번호 있으면) 가격이 높은 순서대로, 
--가격이 낮은 순서대로, 
--주문량이 많은 순서대로, 
--주문량이 적은 순서대로, 
--클릭수가 많은 순서대로, 
--클릭수가 적은 순서대로, 
--세일하고 있는 사이드만 불러오기
 

--(카네고리 번호 있으면) 가격이 높은 순서대로, 
--가격이 낮은 순서대로, 
--주문량이 많은 순서대로, 
--주문량이 적은 순서대로, 
--클릭수가 많은 순서대로, 
--클릭수가 적은 순서대로, 
--세일하고 있는 음료 및 주류만 불러오기


