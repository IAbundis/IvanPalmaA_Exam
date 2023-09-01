<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Plantilla.aspx.cs" Inherits="bExam.Forms.Plantilla" %>
<asp:Content ID="Content1" ContentPlaceHolderID="tittle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    <br />
    <div class="mx-auto" style="width: 300px">
        <asp:Label runat="server" CssClass="h2" ID="lbltitulo"></asp:Label>
    </div>
    <form runat="server" class="h-100 d-flex align-items-center justify-content-center">
        <div>
            <div class="mb-3">
                <br />
                <label class="form-label">Nombre</label>
                <asp:TextBox runat="server" CssClass="form-control" ID="txtName" MaxLength="250" ></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Descripcion</label>
                <asp:TextBox runat="server" CssClass="form-control" ID="txtDescription" MaxLength="250" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnNew" Text="Agregar" Visible="false" OnClick="btnNew_Click" />
            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnUpdate" Text="Actualizar" Visible="false" onclick="btnUpdate_Click"/>
            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnDelete" Text="Eliminar" Visible="false" OnClick="btnDelete_Click" />
            <asp:Button runat="server" CssClass="btn btn-primary btn-dark" ID="btnBack" Text="Regresar" Visible="True" OnClick="btnBack_Click" />
        </div>
    </form>
</asp:Content>
