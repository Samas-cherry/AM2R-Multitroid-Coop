if (!variable_global_exists("opwritelog") || !global.opwritelog)
    exit;

var lfid = file_text_open_append("multitroid_log.txt");
if (lfid != -1)
{
    file_text_write_string(lfid, string(argument0));
    file_text_writeln(lfid);
    file_text_close(lfid);
}
