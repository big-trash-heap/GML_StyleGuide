
enum __API_LINK_LIST {VALUE, NEXT, PREV};

l = new ApiLinkListTwo();

f = l.insEnd(1)
l.insEnd(2)
v2 = l.insEnd(3)
v1 = l.insBegin(0)
l = l.insBegin(-1)

show_message(l)
l.swpRef(f, l);
show_message(l);

l.rem(v1);
show_message(l)
l.rem(v2);
show_message(l)