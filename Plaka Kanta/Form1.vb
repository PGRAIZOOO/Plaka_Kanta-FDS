Public Class Form1
    Private Sub Form1_Resize(sender As Object, e As EventArgs) Handles MyBase.Resize

        PictureBox1.Size = Panel1.ClientSize
        PictureBox1.Location = New Point(0, 0)

    End Sub
    Private Sub Panel1_Layout(sender As Object, e As LayoutEventArgs) Handles Panel1.Layout

        If PictureBox1.Image IsNot Nothing Then
            Dim aspectRatio As Double = PictureBox1.Image.Height / PictureBox1.Image.Width
            PictureBox1.Height = CInt(PictureBox1.Width * aspectRatio)
        End If
    End Sub
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim form2 As New Form2
        form2.Show()
        Me.Hide()
    End Sub
End Class
