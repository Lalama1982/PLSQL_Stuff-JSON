create or replace PROCEDURE PROC_JSON IS
    l_param_list     VARCHAR2(512);

    l_http_request   UTL_HTTP.req;
    l_http_response  UTL_HTTP.resp;

    l_response_text  VARCHAR2(32767);

    l_list system.json_list;
    l_response_obj     system.json;
    
    acl            VARCHAR2(100);
    url            VARCHAR2(1000) := 'http://localhost:8081/PhpProjectFirst/displayValuesSent.php?name=Lalama&email=lalamaesp@gmail.com&gender=male&course=OCA2&class=2008&subject=PL/SQL';
    i pls_integer := 1;
    v_name varchar2(100);
    
BEGIN
    DBMS_OUTPUT.put_line('start');
    l_http_request := utl_http.begin_request(url, 'POST','HTTP/1.1');
    DBMS_OUTPUT.put_line('(01) http request received');
    --utl_http.set_header(l_http_request, 'user-agent', 'mozilla/4.0'); 
    utl_http.set_header(l_http_request, 'Content-Type', 'application/json'); 
    --utl_http.set_header(l_http_request, 'Content-Length', length(content));
    
    --utl_http.write_text(l_http_request, content);
    DBMS_OUTPUT.put_line('(02) Before getting the http response');
    l_http_response := utl_http.get_response(l_http_request);
    DBMS_OUTPUT.put_line('(03) After getting the http response');
    
    -- process the response from the HTTP call
    begin
        DBMS_OUTPUT.put_line('(04) Looping the result');
        loop
            utl_http.read_line(l_http_response, l_response_text);
            dbms_output.put_line('Response(http) >> Text(varchar2) ('||i||') : '||l_response_text);
            l_response_obj := system.json(l_response_text);
            DBMS_OUTPUT.put_line('Text(varchar2) >> JSON : converted ');
            --l_list := system.json_list(l_response_obj.get_values ); 
            l_list := l_response_obj.get_values; 
            dbms_output.put_line('JSON >> JSON_LIST : converted ('||i||') : '||l_list.count);
            v_name := l_response_obj.get('name').to_char();
            dbms_output.put_line('JSON.tag(Name) >> varchar2 : converted ('||i||') : '||v_name);
            
            i := 1+1;
            
        end loop;
        utl_http.end_response(l_http_response);
        
    end;
    
exception
    when utl_http.end_of_body then
        utl_http.end_response(l_http_response);
    when others then
        DBMS_OUTPUT.put_line('Error >> '||sqlerrm);
        utl_http.end_response(l_http_response);
END PROC_JSON;