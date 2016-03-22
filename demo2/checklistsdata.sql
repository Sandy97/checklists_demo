select i.i_id, i.clid, c.cltitle, i.iorder, 'false' as iresult,
g.tx_caption as gr_name, p.tx_caption as iprompt
from clitems i, texts g, texts p, checklist c
where 
    i.gr_name_ref = g.tx_id
and i.iprompt_ref = p.tx_id 
and i.clid = c.clid
