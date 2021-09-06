<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>User Registration and Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container mt-4 font-weight-bold">
            <div class="row">
                <% if (Session["msg"] != null) %>
                <% { %>
                <div class="col-12">
                    <div class="alert alert-warning alert-dismissible fade text-center show" role="alert">
                        <%= Session["msg"] %>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <% Session.Remove("msg"); %>
                <% } %>

                <% if (Session["U_Id"] != null) %>
                <% { %>
                <div class="col-8 offset-2 text-center mt-5">
                    <div class="row <%= edit_mode ? "d-none" : "" %>">
                        <div class="col-lg-4 offset-lg-4 col-6 offset-3 mb-3">
                            <img src="profile/<%= Session["pro"] %>" class="img-fluid w-100" style="border-radius: 50%" />
                        </div>
                    </div>
                    <h1>Welcome, <%= Session["U_Name"] %></h1>
                    <asp:Button ID="edit_pro" runat="server" Text="Edit Profile"
                        CssClass="btn btn-success mt-3 mr-4" OnClick="edit_pro_Click" />
                    <asp:Button ID="b_logout" runat="server" Text="Logout"
                        CssClass="btn btn-success mt-3" OnClick="b_logout_Click" TabIndex="100" />

                </div>
                <% } %>
                <% else %>
                <% { %>
                <div class="col-12 text-center">
                    <h1>Login</h1>
                    <div class="form-group row mt-4 mb-4">
                        <div class="col-4 offset-2">
                            <label>Username</label>
                            <asp:TextBox ID="t_uname_l" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-4">
                            <label>Password</label>
                            <asp:TextBox ID="t_pass_l" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <asp:Button ID="login" runat="server" Text="Login" CssClass="btn btn-success btn-lg" OnClick="login_Click" />
                </div>
                <% } %>

                <% if (Session["U_Id"] == null || edit_mode) %>
                <% { %>
                <div class="col-12 mt-5">
                    <h1 class="text-center <%= edit_mode ? "d-none" : "" %>">Registration</h1>
                    <h1 class="text-center <%= !edit_mode ? "d-none" : "" %>">Edit Profile</h1>
                </div>
                <div class="col-md-3 col-sm-4 col-6 offset-md-0 offset-sm-4 offset-3">
                    <style>
                        .btn-container .btn {
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                            -ms-transform: translate(-50%, -50%);
                            visibility: hidden;
                        }

                        .btn-container:hover .btn {
                            visibility: visible;
                        }
                    </style>
                    <div class="btn-container" style="position: relative;">
                        <img src="profile/<%= Session["pro"] %>" id="pro" class="w-100" style="border-radius: 50%" />
                        <button class="btn btn-success btn-sm" onclick="document.getElementById('f_pro').click()" type="button">Change</button>
                        <asp:FileUpload ID="f_pro" runat="server" CssClass="d-none" />
                    </div>
                    <script>
                        var fr = new FileReader();
                        fr.onload = function (e) {
                            document.getElementById("pro").src = this.result;
                        };
                        document.getElementById("f_pro").addEventListener("change", function () {
                            fr.readAsDataURL(this.files[0]);
                        });
                    </script>
                </div>
                <div class="col-md-9">
                    <div class="form-group row">
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>Name</label>
                            <asp:TextBox ID="t_name" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>Mobile</label>
                            <asp:TextBox ID="t_mobile" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </div>
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>Username</label>
                            <asp:TextBox ID="t_uname_r" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>Password</label>
                            <asp:TextBox ID="t_pass_r" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>DOB</label>
                            <asp:TextBox ID="t_dob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>City</label>
                            <asp:TextBox ID="t_city" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xl-4 col-sm-6 mt-3">
                            <label>Pin code</label>
                            <asp:TextBox ID="t_pin" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </div>
                        <div class="col-xl-8 col-sm-6 mt-3">
                            <label>Address</label>
                            <asp:TextBox ID="t_add" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-12 text-center mt-3">
                    <% b_reg.Visible = !edit_mode; %>
                    <% b_upd.Visible = edit_mode; %>
                    <asp:Button ID="b_reg" runat="server" Text="Register" CssClass="btn btn-success btn-lg" OnClick="b_reg_Click" />
                    <asp:Button ID="b_upd" runat="server" Text="Update"
                        CssClass="btn btn-success btn-lg" OnClick="b_upd_Click" />
                </div>
                <% } %>
            </div>
        </div>
    </form>
</body>

</html>