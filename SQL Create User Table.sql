CREATE TABLE [dbo].[Users] (
    [U_Id]       INT         IDENTITY (1, 1) NOT NULL,
    [U_Name]     NCHAR (30)  NULL,
    [U_Mobile]   NCHAR (20)  NULL,
    [U_Username] NCHAR (20)  NULL,
    [U_Password] NCHAR (50)  NULL,
    [U_Dob]      NCHAR (20)  NULL,
    [U_City]     NCHAR (30)  NULL,
    [U_Pincode]  NCHAR (10)  NULL,
    [U_Address]  NCHAR (200) NULL,
    [U_Profile]  NCHAR (20)  DEFAULT ('photo.png') NULL,
    PRIMARY KEY CLUSTERED ([U_Id] ASC)
);

