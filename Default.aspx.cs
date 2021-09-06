using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    private SqlConnection con;
    private SqlCommand cmd;
    private SqlDataReader dr;
    public String p_path;
    public Boolean edit_mode = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection("Data Source=(LocalDB)\\v11.0;AttachDbFilename=" + Server.MapPath(ConfigurationManager.ConnectionStrings["dbfile"].ConnectionString) + ";Integrated Security=True");
        con.Open();
        p_path = MapPath("profile\\");
        if (Session["pro"] == null)
        {
            Session["pro"] = "photo.png";
        }
    }

    private String m(Object s)
    {
        return s.ToString().Trim();
    }

    private void home(Object msg = null)
    {
        Session["msg"] = msg;
        Response.Redirect("Default.aspx");
    }

    protected void b_reg_Click(object sender, EventArgs e)
    {
        cmd = new SqlCommand("INSERT INTO Users(U_Name, U_Mobile, U_Username, U_Password, U_Dob, U_City, U_Pincode, U_Address) output INSERTED.U_Id VALUES('" + t_name.Text + "', '" + t_mobile.Text + "', '" + t_uname_r.Text + "', '" + t_pass_r.Text + "', '" + t_dob.Text + "', '" + t_city.Text + "', '" + t_pin.Text + "', '" + t_add.Text + "')", con);
        int uid = (int)cmd.ExecuteScalar();
        String pro = "photo.png";
        if (f_pro.HasFile)
        {
            pro = "p_" + m(uid) + new FileInfo(f_pro.FileName).Extension;
            f_pro.SaveAs(p_path + pro);
        }
        cmd = new SqlCommand("UPDATE Users SET U_Profile = '" + pro + "' WHERE U_Id = " + m(uid), con);
        cmd.ExecuteNonQuery();
        home("Registration Successfully, Now You Can Login..");
    }

    protected void login_Click(object sender, EventArgs e)
    {
        cmd = new SqlCommand("SELECT U_Id, U_Name, U_Password, U_Profile FROM Users WHERE U_Username = '" + t_uname_l.Text + "'", con);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (String.Compare(m(dr["U_Password"]), m(t_pass_l.Text)) == 0)
            {
                Session["U_Id"] = dr["U_Id"];
                Session["U_Name"] = m(dr["U_Name"]);
                Session["pro"] = m(dr["U_Profile"]);
                home("Login Successfully");
            }
            else
            {
                home("Invalid Password");
            }
        }
        else
        {
            home("Username Not Found");
        }
    }
    protected void b_upd_Click(object sender, EventArgs e)
    {
        cmd = new SqlCommand("UPDATE Users SET U_Name = '" + t_name.Text + "', U_Mobile = '" + t_mobile.Text + "', U_Username = '" + t_uname_r.Text + "', U_Password = '" + t_pass_r.Text + "', U_Dob = '" + t_dob.Text + "', U_City = '" + t_city.Text + "', U_Pincode = '" + t_pin.Text + "', U_Address = '" + t_add.Text + "' WHERE U_Id = " + Session["U_Id"], con);
        cmd.ExecuteNonQuery();
        if (f_pro.HasFile)
        {
            String pro = "p_" + Session["U_Id"] + new FileInfo(f_pro.FileName).Extension;
            f_pro.SaveAs(p_path + pro);
            cmd = new SqlCommand("UPDATE Users SET U_Profile = '" + pro + "' WHERE U_Id = " + Session["U_Id"], con);
            cmd.ExecuteNonQuery();
            Session["pro"] = pro;
        }
        Session["U_Name"] = t_name.Text;
        home("Profile Update Successfully");
    }


    protected void edit_pro_Click(object sender, EventArgs e)
    {
        this.edit_mode = true;
        cmd = new SqlCommand("SELECT * FROM Users WHERE U_Id = " + Session["U_Id"], con);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            edit_pro.Visible = false;
            b_logout.Visible = false;
            t_name.Text = m(dr["U_Name"]);
            t_mobile.Text = m(dr["U_Mobile"]);
            t_uname_r.Text = m(dr["U_Username"]);
            t_pass_r.Text = m(dr["U_Password"]);
            t_dob.Text = m(dr["U_Dob"]);
            t_city.Text = m(dr["U_City"]);
            t_pin.Text = m(dr["U_Pincode"]);
            t_add.Text = m(dr["U_Address"]);
        }
        dr.Close();
    }

    protected void b_logout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Session.Clear();
        home();
    }
}