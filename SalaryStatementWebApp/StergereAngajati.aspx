<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StergereAngajati.aspx.cs" Inherits="SalaryStatementWebApp.StergereAngajati" %>

<!DOCTYPE html>
<html lang="ro">
<head runat="server">
    <meta charset="utf-8" />
    <title>Ștergere Angajat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .employee-item {
            padding: 15px;
            margin: 10px 0;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .employee-item:hover {
            background-color: #f0f0f0;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
        }
        .delete-confirmation {
            margin-top: 20px;
            padding: 20px;
            border-top: 2px solid #dc3545;
            display: none; /* Initially hidden */
        }
        .alert {
            display: none; /* Initially hidden */
        }
    </style>
    <script type="text/javascript">
        function showDeleteConfirmation(employeeId) {
            // Show the delete confirmation panel
            document.getElementById('deletePanel').style.display = 'block';

            // Set the employee ID to the hidden field for server-side processing
            document.getElementById('<%= hfEmployeeId.ClientID %>').value = employeeId;

            // Display the employee ID in the confirmation message
            document.getElementById('<%= lblConfirmEmployeeId.ClientID %>').innerText = employeeId;
        }

        function hideDeleteConfirmation() {
            // Hide the delete confirmation panel
            document.getElementById('deletePanel').style.display = 'none';
        }

        // This function will be called to refresh the employee list after deletion
        function refreshEmployeeList() {
            document.getElementById('<%= btnSearchEmployee.ClientID %>').click();
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2 class="text-center">Ștergere Angajat</h2>
        <form id="form1" runat="server">
            <div class="form-group">
                <label for="txtSearchName">Căutare Angajat (După Nume):</label>
                <div class="input-group mb-2">
                    <asp:TextBox ID="txtSearchName" runat="server" placeholder="Introdu numele angajatului" CssClass="form-control" />
                    <button type="button" class="btn btn-outline-secondary" onclick="document.getElementById('<%= btnSearchEmployee.ClientID %>').click()">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <asp:Button ID="btnSearchEmployee" runat="server" Text="Căutare" OnClick="btnSearchEmployee_Click" CssClass="d-none" />
            </div>

            <!-- Hidden Field to store Employee ID -->
            <asp:HiddenField ID="hfEmployeeId" runat="server" />

            <!-- Display Search Results -->
            <div class="search-result mt-4">
                <h4>Rezultate Căutare:</h4>
                <asp:Repeater ID="rptEmployees" runat="server" OnItemCommand="rptEmployees_ItemCommand">
                    <ItemTemplate>
                        <div class="employee-item">
                            <div>
                                <strong><%# Eval("Nume") %> <%# Eval("Prenume") %></strong><br />
                                Funcție: <%# Eval("Functie") %> - Salariu: <%# Eval("salar_baza") %>
                            </div>
                            <!-- Trigger delete confirmation when clicked -->
                            <asp:Button 
                                ID="btnDeleteEmployee" 
                                runat="server" 
                                CommandName="DeleteEmployee" 
                                CommandArgument='<%# Eval("nr_crt") %>' 
                                Text="Șterge" 
                                CssClass="btn btn-danger btn-sm" 
                                OnClientClick="showDeleteConfirmation('<%# Eval('nr_crt') %>'); return false;" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
            </div>

            <!-- Delete Confirmation Panel -->
            <div class="delete-confirmation" id="deletePanel" runat="server">
                <h5>Confirmare Ștergere</h5>
                <p>Sigur doriți să ștergeți angajatul cu ID: <asp:Label ID="lblConfirmEmployeeId" runat="server" /></p>
                <!-- Handle the server-side delete action -->
                <asp:Button ID="btnConfirmDelete" runat="server" Text="Ok" OnClick="btnConfirmDelete_Click" CssClass="btn btn-danger" />
                <asp:Button ID="btnCancelDelete" runat="server" Text="Cancel" OnClientClick="hideDeleteConfirmation(); return false;" CssClass="btn btn-secondary" />
            </div>

            <!-- Success Message -->
            <div class="alert alert-success" id="successMessage" runat="server">
                Angajatul a fost șters cu succes!
            </div>

        </form>
    </div>
</body>
</html>
