-- Recupere SIREN < 9 chiffres
-- il faut recuperer "072201114"
declare @siret14 as decimal(14,0)
set @siret14 = 7220111400013
declare @siren8 as decimal(14,0)
set @siren8 = 72201114
select reverse(@siret14) -- retourne 3100041110227
select substring(reverse(@siret14), 6, 9) -- retourne 41110227
select substring(reverse(@siret14), 6, 9) + '000000000' -- retourne 41110227000000000
select left(substring(reverse(@siret14), 6, 9) + '000000000', 9) -- retourne 411102270
select reverse(left(substring(reverse(@siret14), 6, 9) + '000000000', 9)) -- retourne 072201114

-- Pour conserver le format numerique (pour que BO puisse faire des jointures)
select reverse(substring(reverse(@siret14), 6, 9))

-- sql server 2005, convert en varchar(), pas en char() !
select right('000000000' + convert(varchar(9), @siren8), 9) as 'SIREN'
-- sql server 2012
--select format(@siren8, '000000000')