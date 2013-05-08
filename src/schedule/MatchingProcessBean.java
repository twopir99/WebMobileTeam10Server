package schedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;


public class MatchingProcessBean {
	public int Sum(int intPOP01, int intPOP02){
        return intPOP01 + intPOP02;
    }
    public int Sub(int intPOP01 , int intPOP02){
        return intPOP01 - intPOP02;
    };


	public void getMatch(HashMap<String, Object> umap) {
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;
		Statement stmt3 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		
		try {

			conn = DriverManager.getConnection("jdbc:mysql://websys1.stern.nyu.edu:3306/websysS1310", "websysS1310" , "websysS1310!!");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			String date = (String) umap.get("date");
			String timestart = (String) umap.get("timestart");
			String timeend = (String) umap.get("timeend");
			String gender = (String) umap.get("gender");
			String nationality = (String) umap.get("nationality");
			String double_yn = (String) umap.get("double_yn");
			String status = (String) umap.get("status");
			String userid = (String) umap.get("userid");
			String[] agearr = (String[]) umap.get("agearr");
			String[] levelarr = (String[]) umap.get("levelarr");
			
			String age2 = "";
			
			
			StringBuffer sql1 = new StringBuffer();
			sql1.append("select ");
			sql1.append("a.schedule_id, a.user_id as p_user_id, a.gender as p_gender, a.nationality as p_nationality, a.date,  ");
			sql1.append("a.timeslot_start, a.timeslot_end, a.status, a.status_push, a.status_mail, a.double_yn,  ");
			sql1.append("a.match_result_id, a.create_date, a.mod_date,  ");
			sql1.append("b.user_id as p_user_id, b.password, b.name, b.level as p_user_level, b.gender as p_user_gender,  ");
			sql1.append("b.age as p_user_age, b.nationality as p_user_nationality, b.email, b.phone_number  ");
			
			sql1.append("from schedule a join user b ");
			sql1.append("	on a.user_id = b.user_id ");
			sql1.append("where a.schedule_id != (select get_curr_seq_val('schedule')) ");
			sql1.append("and a.date = '" +date+ "' " );
			sql1.append("and a.timeslot_start = '" +timestart+ "' ");
			sql1.append("and a.timeslot_end = '" +timeend+ "' ");
			
			if(!nationality.equals("any")){
				sql1.append("and b.nationality = '" +nationality + "' ");
			}
			if(!gender.equals("any")){
				sql1.append("and b.gender = '" +gender + "' ");
			}
			
			sql1.append("and b.level in ( ");
			for(int i=0; i<levelarr.length;i++){
				sql1.append("						'"+levelarr[i]+"'		");
				if(i != levelarr.length-1){
					sql1.append("					,		");
				}
			}
			sql1.append("			) ");
			
			sql1.append("and ( ");
			for(int i=0; i<agearr.length;i++){
				if(agearr[i].equals("10")){
					age2 = "13";
				}else if(agearr[i].equals("14")){
					age2 = "17";
				}else if(agearr[i].equals("18")){
					age2 = "39";
				}else if(agearr[i].equals("40")){
					age2 = "54";
				}else{
					age2 = "200";
				}
				sql1.append("	( b.age	between '"+agearr[i]+"' and '"+age2+"' )		");
				if(i != agearr.length-1){
					sql1.append("					or		");
				}
			}
			sql1.append("							) ");
			
			sql1.append("and a.status = '1' ");
			sql1.append("and a.date >= DATE_FORMAT(now(), '%Y%m%d') ");
			sql1.append("and a.user_id != '"+userid+"' ");
			sql1.append("order by create_date asc");
					
			System.out.println("QUERY sql1 ::: " + sql1.toString() );
			if (stmt.execute(sql1.toString())) {
				rs = stmt.getResultSet();
			}

			while (rs.next()) {
				
				StringBuffer sql2 = new StringBuffer();
				sql2.append("select name as u_user_name, level as u_user_level, gender as u_user_gender, age as u_user_age, ");
				sql2.append("nationality as u_user_nationality, email, phone_number ");
				sql2.append("from user a ");
				sql2.append("where a.user_id != '"+userid+"' ");

				System.out.println("QUERY sql2 ::: " + sql2.toString() );
				stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs2 = stmt2.executeQuery(sql2.toString());
				
				String u_user_name = "";
				String u_user_level = "";
				String u_user_gender = "";
				String u_user_age = "";
				String u_user_nationality = "";
				if(rs2.next()){
					u_user_name = rs2.getString("u_user_name");
					u_user_level = rs2.getString("u_user_level");
					u_user_gender = rs2.getString("u_user_gender");
					u_user_age = rs2.getString("u_user_age");
					u_user_nationality = rs2.getString("u_user_nationality");
				}
				
				
				
				String p_nationality = rs.getString("p_nationality");
				if(p_nationality.equals("any")){
					//pass
					
				}else{
					if(p_nationality.equals(u_user_nationality)){
						//pass
					}else{
						//stop
						continue;
					}
				}
				
				String p_gender = rs.getString("p_gender");
				if(p_gender.equals("any")){
					//pass
				}else{
					if(p_gender.equals(u_user_gender)){
						//pass
					}else{
						//stop
						continue;
					}
				}
				System.out.println(p_nationality);
				
				StringBuffer sql3 = new StringBuffer();
				sql3.append("update schedule  ");
				sql3.append("set status = '2',  ");
				sql3.append("    match_result_id = (select get_next_seq_val('matchresult')),  ");
				sql3.append("    mod_date = now()  ");
				sql3.append("where schedule_id = ( select get_curr_seq_val('schedule') )");
				stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
				int rscnt = 0;
				System.out.println("QUERY sql3 ::: " + sql3.toString() );
				rscnt = stmt3.executeUpdate(sql3.toString());
				
				StringBuffer sql4 = new StringBuffer();
				sql4.append("update schedule  ");
				sql4.append("set status = '2',  ");
				sql4.append("    match_result_id = (select get_curr_seq_val('matchresult')),  ");
				sql4.append("    mod_date = now()  ");
				sql4.append("where schedule_id = '"+ rs.getString("schedule_id") +"' ");
				int rscnt2 = 0;
				System.out.println("QUERY sql4 ::: " + sql4.toString() );
				rscnt2 = stmt3.executeUpdate(sql4.toString());
				
			}
			
		} catch (SQLException sqex) {
			System.out.println("SQLException: " + sqex.getMessage());
			System.out.println("SQLState: " + sqex.getSQLState());
		} finally{
			try {
				rs.close();
				
				stmt.close();
				
				conn.close();
				/*
				if(rs2!=null){
					rs2.close();
				}
				rs3.close();
				rs4.close();
				stmt2.close();
				stmt3.close();
				*/
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
}