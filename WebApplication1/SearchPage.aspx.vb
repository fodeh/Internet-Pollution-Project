Imports System.Data
Imports System.Data.SqlClient
Imports System.Windows.Forms
Imports System.IO
Imports System.Net
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Xml
Imports System.Web.Script.Serialization

'Internet search filter web form: Use this to gather filtered, and sorted data from google using the custom search API. The goal is to minimize the amount of
'unwanted search results that get pulled normally while using google. Along with built in search filters, the user can select specific dates, and filetypes to
'search for. They may also toggle the safe sarch if they so choose.


Public Class WebForm2
    Inherits System.Web.UI.Page
    Private path As String = ""
    Private counter As Integer = 1
    Private connection As SqlConnection = New SqlConnection
    Private sDate As String = ""
    Private eDate As String = ""
    Private safeCheck1 As String = "off"
    Private file As String = ""

    'Establishes parameters to use when creating a custom search
    Public Sub CustomSearch()
        dateParse()
        searchSettings()
        Dim fileSearch As String = ""
        Dim sortString As String = ""
        Dim searchLink As String = "https://www.googleapis.com/customsearch/v1?key=AIzaSyCuXuw7YMHXddOkNjF0k6Qlj_wS4hx2kzc&cx=016107894799567055183:cq-1idbvrt4&q="
        Dim extraParam As String = "&start=" ' This filters results displayed : "&fields=kind,items(title)"   "&start=(num)" for different pages
        Dim searchCriteria As String = TextBox1.Text
        If sDate = "" Then
            sortString = ""
        Else
            sortString = "&sort=date:r:" + sDate + ":" + eDate
        End If
        Dim safeParam As String = "&safe=" + safeCheck1
        If file = "" Then
            fileSearch = ""
        Else
            fileSearch = "&fileType=" + file
        End If
        Dim finalSearch As String = searchLink + searchCriteria + extraParam + counter.ToString + sortString + safeParam + fileSearch
        Debug.WriteLine(searchLink + searchCriteria + extraParam + counter.ToString + sortString + safeParam + fileSearch)
        Search_Link.NavigateUrl = finalSearch
    End Sub

    'pulls data from start and end date fields and seperates values, then rearranges them for use in the api
    Public Sub dateParse()
        If StartDate.Text = "" Or StartDate.Text = "YYYY/MM/DD" Then
            sDate = ""
        Else
            sDate = StartDate.Text.Replace("/", "")
        End If
        If EndDate.Text = "" Or StartDate.Text = "YYYY/MM/DD" Then
            Dim currentDate As Date = Date.Now
            Dim modifiedDate As String = currentDate.ToString("yyyyMMdd")
            eDate = modifiedDate
        Else
            eDate = EndDate.Text.Replace("/", "")
        End If
    End Sub

    'handles safe search check and file type filter if selected
    Public Sub searchSettings()
        If SafeCheck.Checked Then
            safeCheck1 = "active"
        End If

        If fileType.Text = "" Or fileType.Text = ".ex" Then
            file = ""
        Else
            file = fileType.Text
        End If
    End Sub

    'On page load establish sql connection to local db, open table and clear pre existing data for a new instance.
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        QueryConnection()
        Dim query1 As New SqlCommand("delete from pollution_data", connection)
        query1.ExecuteNonQuery()
        Close()
    End Sub

    'Runs search once button is clicked, and retrieves output.
    Protected Sub Search_Button_Click(sender As Object, e As EventArgs) Handles Search_Button.Click
        Dim i As Integer = 0
        Dim TitleArray As JArray = New JArray
        Dim SnippetArray As JArray = New JArray
        Dim LinkArray As JArray = New JArray

        Dim initialString As String = TextBox1.Text
        Dim splitArray() As String
        splitArray = initialString.Split(" "c)

        CustomSearch()
        'Redirect()

        While counter <= 100
            CustomSearch()
            Dim request = HttpWebRequest.CreateHttp(Search_Link.NavigateUrl)
            Dim reader As StreamReader
            request = DirectCast(WebRequest.Create(Search_Link.NavigateUrl), HttpWebRequest)
            Dim response1 = DirectCast(Request.getresponse(), HttpWebResponse)
            reader = New StreamReader(response1.GetResponseStream())
            Dim objtext = reader.ReadToEnd
            Dim obj As JObject = JsonConvert.DeserializeObject(Of Object)(objtext)
            Dim tobj As JArray = obj.getvalue("items")
            counter = counter + 10

            i = 0
            While i < 10
                Dim arrayobj As JObject = tobj(i)
                TitleArray.Add(arrayobj.GetValue("title"))
                SnippetArray.Add(arrayobj.getvalue("snippet"))
                LinkArray.Add(arrayobj.GetValue("link"))
                i = i + 1
            End While
        End While

        QueryConnection()

        Dim j As Integer = 0
        While j < 100
            Dim TitleParam As String = Replace(TitleArray(j).ToString, "'", "''")
            Dim snippetParam As String = Replace(SnippetArray(j).ToString, "'", "''")
            Dim linkParam As String = Replace(LinkArray(j).ToString, "'", "''")
            Dim query As String = "insert into Pollution_data (title, snippet, link) values ('" + TitleParam + "', '" + snippetParam + "', '" + linkParam + "')"
            Dim query1 As New SqlCommand(query, connection)
            query1.ExecuteNonQuery()
            'GridView1.DataBind()
            j = j + 1
        End While

        'sort by secure sites
        Dim SortQuery As String = "Select * From pollution_data Order By case when snippet Like '%hours ago%' then 1 when link like '%day ago%' then 2 when snippet like '%days ago%' then 3 when snippet like '%https%' then 4 else 5 end"
        Dim SortQuery1 As New SqlCommand(SortQuery, connection)
        SortQuery1.ExecuteNonQuery()


        GridView1.DataBind()
        GridView1.Visible = True
        Close()
    End Sub

    'Call to redirect browser to json reuslts. Used for testing.
    Protected Sub Redirect()
        Response.Redirect(Search_Link.NavigateUrl, False)
        Context.ApplicationInstance.CompleteRequest()
    End Sub

    'establishes connection to run queries
    Protected Sub QueryConnection()
        connection.ConnectionString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
        connection.Open()
    End Sub

    'close connection to db
    Protected Sub Close()
        connection.Close()
    End Sub
End Class