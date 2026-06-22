Imports MySql.Data.MySqlClient

Public Class Form2
    Dim conn As MySqlConnection = New MySqlConnection("Data Source=localhost;Database=Plaka_Kanta;User=root;Password=")
    Public sql As String
    Public dbcomm As MySqlCommand
    Public dbread As MySqlDataReader
    Public DataAdapter1 As MySqlDataAdapter
    Public ds As DataSet

    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        Dim f1 As New Form1
        f1.Show()
        Me.Close()
    End Sub

    Private Sub SHOW_btn_Click(sender As Object, e As EventArgs) Handles SHOW_btn.Click
        Dim ans As String = InputBox("Enter a table to show: ")

        If ans = "" Then Exit Sub

        Try
            conn.Open()
            sql = "SELECT * FROM " & ans & ""

            DataAdapter1 = New MySqlDataAdapter(sql, conn)
            ds = New DataSet()
            DataAdapter1.Fill(ds, ans)

            DataGridView1.DataSource = ds.Tables(ans)

        Catch ex As Exception
            MsgBox("Error in collecting data from Database. Error is :" & ex.Message)
        End Try

        conn.Close()
    End Sub
End Class