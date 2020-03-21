set define off;
BEGIN
  SYS.DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'www.xml',
                                        description => 'TEST JSON',
                                        principal   => 'TEST_USER',
                                        is_grant    => true,
                                        privilege   => 'connect',
                                        start_date   => SYSTIMESTAMP,
                                        end_date     => NULL);
 
  SYS.DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'www.xml',
                                           principal => 'TEST_USER',
                                           is_grant  => true,
                                           privilege => 'resolve');
 
  SYS.DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'www.xml',
                                        --host => 'http://localhost:8081/PhpProjectFirst/displayValuesSent.php?name=Lalama&email=lalamaesp@gmail.com&gender=male&course=OCA2&class=2008&subject=PL/SQL'
                                        host        => 'localhost',
                                        lower_port  => 8081,
                                        upper_port  => NULL);
END;