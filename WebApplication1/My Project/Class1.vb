Imports System.Data
Imports System.Data.SqlClient
Imports System.Windows.Forms
Imports SearchPage.aspx
Partial Class Class1
    Inherits System.Web.UI.Page


    Function DataReader()

        Dim Sql As New SqlClient.SqlConnection
        Dim StrSql As String = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;Connect Timeout=30" 'NT Authentication
        Dim strCommand As String = "SELECT * FROM TABLE"
        Dim command As SqlCommand
        Dim da As SqlDataAdapter
        Dim dt As DataTable

        Try
            Sql.ConnectionString = StrSql
            command = New SqlCommand(strCommand, Sql)
            command.CommandTimeout = 3000

            da = New SqlDataAdapter(command)
            da.Fill(dt)
            MsgBox(dt.Rows.Count.ToString())

        Catch ex As Exception
            MessageBox.Show(ex.Message, "Error")

        Finally
            If Sql.State = ConnectionState.Open Then
                Sql.Close()
            End If

        End Try

    End Function
End Class
