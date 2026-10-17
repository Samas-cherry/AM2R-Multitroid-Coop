var lfid = file_text_open_append("multitroid_log.txt");
if (lfid != -1)
{
    file_text_write_string(lfid, string(argument0));
    file_text_writeln(lfid);
    file_text_close(lfid);
}
var lfid2 = file_text_open_append("E:/Project Codes/AM2R co-op/net_debug.log");
if (lfid2 != -1)
{
    file_text_write_string(lfid2, string(argument0));
    file_text_writeln(lfid2);
    file_text_close(lfid2);
}
