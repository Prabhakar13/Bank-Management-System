/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connection;

/**
 *
 * @author HP
 */
import java.sql.*;
import oracle.jdbc.OracleConnection;
public class connection {
    public static void main(String[] args){
        String url="jdbc:oracle:thin:@localhost:1521:orcl";
        PreparedStatement pst=null;
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Driver Loaded !");
            try (Connection con = DriverManager.getConnection(url,"system","pksinha786")) {
                System.out.println("Connection Established ! "+ con);
                
                String sqlQuery = "select * from testEmployee";
                    pst = con.prepareStatement(sqlQuery);
                    ResultSet rs = pst.executeQuery();
                    while(rs.next()){
                        System.out.println(rs.getString(1)+" "+rs.getString(2));
                    }
                
                
//                 CallableStatement callstmt = con.prepareCall("{CALL first_proc(?,?)}");
//                 System.out.println("Here");
//        callstmt.registerOutParameter(2,Types.INTEGER);
//        callstmt.setInt(1,20);
//        System.out.println("Here");
//        callstmt.execute();
//        System.out.println("Here");
//        int res = callstmt.getInt(2);
//        System.out.println("Result is :" + res);
//        callstmt.close();
        
        
//            System.out.println("Here");
//            String query="select * from system.testEmployee";
//            System.out.println("Here");
//            Statement st=con.createStatement();
//            System.out.println("Here--");
//            ResultSet rs=st.executeQuery(query);
//            System.out.println("Here");
//            while(rs.next())
//            {
//                String num=rs.getString("ID");
//                String name=rs.getString("NAME");
//                System.out.println(num+" "+name);
//            }
//            st.close();
//            pst=con.prepareStatement(sqlQuery);
//            pst.setString(1,"001");
//            pst.setString(2,"Naga");
//            System.out.println("Here");
//            pst.executeUpdate();
//            System.out.println("Here");
//            pst.close();
            con.close();
            }
        }
        catch(ClassNotFoundException e){
            System.out.println("Driver Not Loaded !");
        }
        catch(SQLException e){
            System.out.println("Connection Not Established ! "+ e);
        }
    }
}
