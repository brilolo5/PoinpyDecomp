function input_value_is_binding(arg0)
{
    return is_struct(arg0) && variable_struct_exists(arg0, "type") && variable_struct_exists(arg0, "value") && variable_struct_exists(arg0, "axis_negative") && variable_struct_exists(arg0, "value_b") && variable_struct_names_count(arg0) == 3;
}
