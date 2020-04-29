--join1
SELECT lprod.lprod_gu,lprod.lprod_nm, prod.prod_id, prod.prod_name -- �ϳ��� ���̺��� �����ϴ� �÷��� ���̺�.�÷� ������ ������� �ʾƵ� �ȴ�.
FROM prod, lprod  --lprod�� ���� ���̺��̹Ƿ� ���� ������ִ°� �������鿡�� ����.
WHERE prod.prod_lgu = lprod_gu;
--�⺻������ oracle���� 50���� �ุ�� ���� ������ִ� ����¡ó���� �Ǿ��ִ�.
SELECT lprod.lprod_gu,lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod_gu);

--join2
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

--join2_1
SELECT COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;

--join2_2
--buyer_name�� �Ǽ� ��ȸ ���� �ۼ�
SELECT buyer.buyer_name, COUNT(buyer.buyer_name)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer
GROUP BY buyer.buyer_name;

--join3
--3���� ���̺��� ����
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN (cart JOIN prod ON( cart.cart_prod = prod.prod_id)) ON (member.mem_id = cart.cart_member);

--
SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle;

--join 4
SELECT customer.CID, customer.CNM, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid AND (cnm = 'brown' OR cnm = 'sally');

SELECT CID, CNM, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE cnm = 'brown' OR cnm = 'sally';

--join 5
SELECT customer.CID, customer.CNM, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid AND (cnm = 'brown' OR cnm = 'sally');

--join 6
SELECT customer.CID, customer.CNM, cycle.pid, product.pnm, SUM(cycle.cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY customer.CID, customer.CNM, cycle.pid, product.pnm;

--join7
SELECT product.pid, product.pnm, SUM(cycle.cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY product.pid, product.pnm; -- Group Function �ȿ� ����� �÷��� Group by���� ������� �ʰ� ����ϴ� �͵� �����ϴ�.

























