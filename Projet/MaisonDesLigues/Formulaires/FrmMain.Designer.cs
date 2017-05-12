namespace MaisonDesLigues
{
    partial class FrmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.materialTabSelector1 = new MaterialSkin.Controls.MaterialTabSelector();
            this.TabType = new MaterialSkin.Controls.MaterialTabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.PnlNuite = new System.Windows.Forms.Panel();
            this.RdoNuitéNon = new MaterialSkin.Controls.MaterialRadioButton();
            this.RdoNuitéOui = new MaterialSkin.Controls.MaterialRadioButton();
            this.CmbAtelier = new System.Windows.Forms.ComboBox();
            this.lblAtelier = new MaterialSkin.Controls.MaterialLabel();
            this.PnlType = new System.Windows.Forms.Panel();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.materialLabel13 = new MaterialSkin.Controls.MaterialLabel();
            this.materialLabel12 = new MaterialSkin.Controls.MaterialLabel();
            this.txtNaissance = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.panel2 = new System.Windows.Forms.Panel();
            this.txtLicence = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.BtnQuitter = new MaterialSkin.Controls.MaterialFlatButton();
            this.TxtMail = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.TxtTel = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.TxtVille = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.LblVille = new MaterialSkin.Controls.MaterialLabel();
            this.TxtCp = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.TxtAdresse = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.TxtPrenom = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.TxtNom = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.materialLabel7 = new MaterialSkin.Controls.MaterialLabel();
            this.LblTel = new MaterialSkin.Controls.MaterialLabel();
            this.LblCp = new MaterialSkin.Controls.MaterialLabel();
            this.LblPrenom = new MaterialSkin.Controls.MaterialLabel();
            this.LblAdresse = new MaterialSkin.Controls.MaterialLabel();
            this.LblNom = new MaterialSkin.Controls.MaterialLabel();
            this.GpbIdentité = new System.Windows.Forms.GroupBox();
            this.TxtAdresse2 = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.BtnEnregistrer = new MaterialSkin.Controls.MaterialFlatButton();
            this.materialFlatButton1 = new MaterialSkin.Controls.MaterialFlatButton();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.materialFlatButton2 = new MaterialSkin.Controls.MaterialFlatButton();
            this.TabType.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.GpbIdentité.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // materialTabSelector1
            // 
            this.materialTabSelector1.BaseTabControl = this.TabType;
            this.materialTabSelector1.Depth = 0;
            this.materialTabSelector1.Location = new System.Drawing.Point(0, 64);
            this.materialTabSelector1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabSelector1.Name = "materialTabSelector1";
            this.materialTabSelector1.Size = new System.Drawing.Size(1199, 35);
            this.materialTabSelector1.TabIndex = 0;
            this.materialTabSelector1.Text = "materialTabSelector1";
            // 
            // TabType
            // 
            this.TabType.Controls.Add(this.tabPage1);
            this.TabType.Controls.Add(this.tabPage2);
            this.TabType.Controls.Add(this.tabPage3);
            this.TabType.Depth = 0;
            this.TabType.Location = new System.Drawing.Point(475, 109);
            this.TabType.MouseState = MaterialSkin.MouseState.HOVER;
            this.TabType.Name = "TabType";
            this.TabType.SelectedIndex = 0;
            this.TabType.Size = new System.Drawing.Size(710, 423);
            this.TabType.TabIndex = 1;
            // 
            // tabPage1
            // 
            this.tabPage1.BackColor = System.Drawing.Color.White;
            this.tabPage1.Controls.Add(this.groupBox3);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(702, 397);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Intervenant";
            this.tabPage1.Click += new System.EventHandler(this.tabPage1_Click);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.groupBox2);
            this.groupBox3.Controls.Add(this.CmbAtelier);
            this.groupBox3.Controls.Add(this.lblAtelier);
            this.groupBox3.Controls.Add(this.PnlType);
            this.groupBox3.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F);
            this.groupBox3.Location = new System.Drawing.Point(6, 7);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(686, 384);
            this.groupBox3.TabIndex = 20;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Complément d\'inscription des Intervenants";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.PnlNuite);
            this.groupBox2.Controls.Add(this.RdoNuitéNon);
            this.groupBox2.Controls.Add(this.RdoNuitéOui);
            this.groupBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F);
            this.groupBox2.Location = new System.Drawing.Point(13, 163);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(663, 215);
            this.groupBox2.TabIndex = 19;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Nuités";
            // 
            // PnlNuite
            // 
            this.PnlNuite.Location = new System.Drawing.Point(16, 58);
            this.PnlNuite.Name = "PnlNuite";
            this.PnlNuite.Size = new System.Drawing.Size(636, 147);
            this.PnlNuite.TabIndex = 26;
            // 
            // RdoNuitéNon
            // 
            this.RdoNuitéNon.AutoSize = true;
            this.RdoNuitéNon.Depth = 0;
            this.RdoNuitéNon.Font = new System.Drawing.Font("Roboto", 10F);
            this.RdoNuitéNon.Location = new System.Drawing.Point(129, 27);
            this.RdoNuitéNon.Margin = new System.Windows.Forms.Padding(0);
            this.RdoNuitéNon.MouseLocation = new System.Drawing.Point(-1, -1);
            this.RdoNuitéNon.MouseState = MaterialSkin.MouseState.HOVER;
            this.RdoNuitéNon.Name = "RdoNuitéNon";
            this.RdoNuitéNon.Ripple = true;
            this.RdoNuitéNon.Size = new System.Drawing.Size(54, 30);
            this.RdoNuitéNon.TabIndex = 1;
            this.RdoNuitéNon.TabStop = true;
            this.RdoNuitéNon.Text = "Non";
            this.RdoNuitéNon.UseVisualStyleBackColor = true;
            this.RdoNuitéNon.CheckedChanged += new System.EventHandler(this.RdbNuiteIntervenant_CheckedChanged);
            // 
            // RdoNuitéOui
            // 
            this.RdoNuitéOui.AutoSize = true;
            this.RdoNuitéOui.Depth = 0;
            this.RdoNuitéOui.Font = new System.Drawing.Font("Roboto", 10F);
            this.RdoNuitéOui.Location = new System.Drawing.Point(19, 27);
            this.RdoNuitéOui.Margin = new System.Windows.Forms.Padding(0);
            this.RdoNuitéOui.MouseLocation = new System.Drawing.Point(-1, -1);
            this.RdoNuitéOui.MouseState = MaterialSkin.MouseState.HOVER;
            this.RdoNuitéOui.Name = "RdoNuitéOui";
            this.RdoNuitéOui.Ripple = true;
            this.RdoNuitéOui.Size = new System.Drawing.Size(50, 30);
            this.RdoNuitéOui.TabIndex = 0;
            this.RdoNuitéOui.TabStop = true;
            this.RdoNuitéOui.Text = "Oui";
            this.RdoNuitéOui.UseVisualStyleBackColor = true;
            this.RdoNuitéOui.CheckedChanged += new System.EventHandler(this.RdbNuiteIntervenant_CheckedChanged);
            // 
            // CmbAtelier
            // 
            this.CmbAtelier.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.CmbAtelier.FormattingEnabled = true;
            this.CmbAtelier.Location = new System.Drawing.Point(72, 34);
            this.CmbAtelier.Name = "CmbAtelier";
            this.CmbAtelier.Size = new System.Drawing.Size(265, 26);
            this.CmbAtelier.TabIndex = 26;
            // 
            // lblAtelier
            // 
            this.lblAtelier.AutoSize = true;
            this.lblAtelier.Depth = 0;
            this.lblAtelier.Font = new System.Drawing.Font("Roboto", 11F);
            this.lblAtelier.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblAtelier.Location = new System.Drawing.Point(9, 36);
            this.lblAtelier.MouseState = MaterialSkin.MouseState.HOVER;
            this.lblAtelier.Name = "lblAtelier";
            this.lblAtelier.Size = new System.Drawing.Size(57, 19);
            this.lblAtelier.TabIndex = 17;
            this.lblAtelier.Text = "Atelier:";
            // 
            // PnlType
            // 
            this.PnlType.Location = new System.Drawing.Point(13, 75);
            this.PnlType.Name = "PnlType";
            this.PnlType.Size = new System.Drawing.Size(168, 71);
            this.PnlType.TabIndex = 25;
            // 
            // tabPage2
            // 
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(702, 397);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Licencié";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // tabPage3
            // 
            this.tabPage3.BackColor = System.Drawing.Color.White;
            this.tabPage3.Controls.Add(this.groupBox1);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(702, 397);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Bénévole";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.materialLabel13);
            this.groupBox1.Controls.Add(this.materialLabel12);
            this.groupBox1.Controls.Add(this.txtNaissance);
            this.groupBox1.Controls.Add(this.panel2);
            this.groupBox1.Controls.Add(this.txtLicence);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F);
            this.groupBox1.Location = new System.Drawing.Point(6, 7);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(369, 307);
            this.groupBox1.TabIndex = 20;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Nuités";
            // 
            // materialLabel13
            // 
            this.materialLabel13.AutoSize = true;
            this.materialLabel13.Depth = 0;
            this.materialLabel13.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel13.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel13.Location = new System.Drawing.Point(18, 83);
            this.materialLabel13.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel13.Name = "materialLabel13";
            this.materialLabel13.Size = new System.Drawing.Size(139, 19);
            this.materialLabel13.TabIndex = 22;
            this.materialLabel13.Text = "Numéro de licence:";
            // 
            // materialLabel12
            // 
            this.materialLabel12.AutoSize = true;
            this.materialLabel12.Depth = 0;
            this.materialLabel12.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel12.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel12.Location = new System.Drawing.Point(18, 35);
            this.materialLabel12.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel12.Name = "materialLabel12";
            this.materialLabel12.Size = new System.Drawing.Size(136, 19);
            this.materialLabel12.TabIndex = 20;
            this.materialLabel12.Text = "Date de naissance:";
            // 
            // txtNaissance
            // 
            this.txtNaissance.Depth = 0;
            this.txtNaissance.Hint = "";
            this.txtNaissance.Location = new System.Drawing.Point(163, 35);
            this.txtNaissance.MouseState = MaterialSkin.MouseState.HOVER;
            this.txtNaissance.Name = "txtNaissance";
            this.txtNaissance.PasswordChar = '\0';
            this.txtNaissance.SelectedText = "";
            this.txtNaissance.SelectionLength = 0;
            this.txtNaissance.SelectionStart = 0;
            this.txtNaissance.Size = new System.Drawing.Size(177, 23);
            this.txtNaissance.TabIndex = 21;
            this.txtNaissance.UseSystemPasswordChar = false;
            // 
            // panel2
            // 
            this.panel2.Location = new System.Drawing.Point(22, 140);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(318, 115);
            this.panel2.TabIndex = 26;
            // 
            // txtLicence
            // 
            this.txtLicence.Depth = 0;
            this.txtLicence.Hint = "";
            this.txtLicence.Location = new System.Drawing.Point(163, 83);
            this.txtLicence.MouseState = MaterialSkin.MouseState.HOVER;
            this.txtLicence.Name = "txtLicence";
            this.txtLicence.PasswordChar = '\0';
            this.txtLicence.SelectedText = "";
            this.txtLicence.SelectionLength = 0;
            this.txtLicence.SelectionStart = 0;
            this.txtLicence.Size = new System.Drawing.Size(177, 23);
            this.txtLicence.TabIndex = 23;
            this.txtLicence.UseSystemPasswordChar = false;
            // 
            // BtnQuitter
            // 
            this.BtnQuitter.AutoSize = true;
            this.BtnQuitter.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.BtnQuitter.Depth = 0;
            this.BtnQuitter.Location = new System.Drawing.Point(265, 486);
            this.BtnQuitter.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.BtnQuitter.MouseState = MaterialSkin.MouseState.HOVER;
            this.BtnQuitter.Name = "BtnQuitter";
            this.BtnQuitter.Primary = false;
            this.BtnQuitter.Size = new System.Drawing.Size(204, 36);
            this.BtnQuitter.TabIndex = 18;
            this.BtnQuitter.Text = "=> Quitter l\'application <=";
            this.BtnQuitter.UseVisualStyleBackColor = true;
            // 
            // TxtMail
            // 
            this.TxtMail.Depth = 0;
            this.TxtMail.Hint = "";
            this.TxtMail.Location = new System.Drawing.Point(233, 174);
            this.TxtMail.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtMail.Name = "TxtMail";
            this.TxtMail.PasswordChar = '\0';
            this.TxtMail.SelectedText = "";
            this.TxtMail.SelectionLength = 0;
            this.TxtMail.SelectionStart = 0;
            this.TxtMail.Size = new System.Drawing.Size(208, 23);
            this.TxtMail.TabIndex = 15;
            this.TxtMail.UseSystemPasswordChar = false;
            // 
            // TxtTel
            // 
            this.TxtTel.Depth = 0;
            this.TxtTel.Hint = "";
            this.TxtTel.Location = new System.Drawing.Point(46, 174);
            this.TxtTel.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtTel.Name = "TxtTel";
            this.TxtTel.PasswordChar = '\0';
            this.TxtTel.SelectedText = "";
            this.TxtTel.SelectionLength = 0;
            this.TxtTel.SelectionStart = 0;
            this.TxtTel.Size = new System.Drawing.Size(125, 23);
            this.TxtTel.TabIndex = 14;
            this.TxtTel.UseSystemPasswordChar = false;
            // 
            // TxtVille
            // 
            this.TxtVille.Depth = 0;
            this.TxtVille.Hint = "";
            this.TxtVille.Location = new System.Drawing.Point(269, 137);
            this.TxtVille.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtVille.Name = "TxtVille";
            this.TxtVille.PasswordChar = '\0';
            this.TxtVille.SelectedText = "";
            this.TxtVille.SelectionLength = 0;
            this.TxtVille.SelectionStart = 0;
            this.TxtVille.Size = new System.Drawing.Size(172, 23);
            this.TxtVille.TabIndex = 13;
            this.TxtVille.UseSystemPasswordChar = false;
            // 
            // LblVille
            // 
            this.LblVille.AutoSize = true;
            this.LblVille.Depth = 0;
            this.LblVille.Font = new System.Drawing.Font("Roboto", 11F);
            this.LblVille.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.LblVille.Location = new System.Drawing.Point(220, 137);
            this.LblVille.MouseState = MaterialSkin.MouseState.HOVER;
            this.LblVille.Name = "LblVille";
            this.LblVille.Size = new System.Drawing.Size(43, 19);
            this.LblVille.TabIndex = 12;
            this.LblVille.Text = "Ville:";
            // 
            // TxtCp
            // 
            this.TxtCp.Depth = 0;
            this.TxtCp.Hint = "";
            this.TxtCp.Location = new System.Drawing.Point(46, 141);
            this.TxtCp.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtCp.Name = "TxtCp";
            this.TxtCp.PasswordChar = '\0';
            this.TxtCp.SelectedText = "";
            this.TxtCp.SelectionLength = 0;
            this.TxtCp.SelectionStart = 0;
            this.TxtCp.Size = new System.Drawing.Size(116, 23);
            this.TxtCp.TabIndex = 11;
            this.TxtCp.UseSystemPasswordChar = false;
            // 
            // TxtAdresse
            // 
            this.TxtAdresse.Depth = 0;
            this.TxtAdresse.Hint = "";
            this.TxtAdresse.Location = new System.Drawing.Point(86, 69);
            this.TxtAdresse.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtAdresse.Name = "TxtAdresse";
            this.TxtAdresse.PasswordChar = '\0';
            this.TxtAdresse.SelectedText = "";
            this.TxtAdresse.SelectionLength = 0;
            this.TxtAdresse.SelectionStart = 0;
            this.TxtAdresse.Size = new System.Drawing.Size(355, 23);
            this.TxtAdresse.TabIndex = 10;
            this.TxtAdresse.UseSystemPasswordChar = false;
            // 
            // TxtPrenom
            // 
            this.TxtPrenom.Depth = 0;
            this.TxtPrenom.Hint = "";
            this.TxtPrenom.Location = new System.Drawing.Point(308, 32);
            this.TxtPrenom.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtPrenom.Name = "TxtPrenom";
            this.TxtPrenom.PasswordChar = '\0';
            this.TxtPrenom.SelectedText = "";
            this.TxtPrenom.SelectionLength = 0;
            this.TxtPrenom.SelectionStart = 0;
            this.TxtPrenom.Size = new System.Drawing.Size(133, 23);
            this.TxtPrenom.TabIndex = 9;
            this.TxtPrenom.UseSystemPasswordChar = false;
            // 
            // TxtNom
            // 
            this.TxtNom.Depth = 0;
            this.TxtNom.Hint = "";
            this.TxtNom.Location = new System.Drawing.Point(86, 32);
            this.TxtNom.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtNom.Name = "TxtNom";
            this.TxtNom.PasswordChar = '\0';
            this.TxtNom.SelectedText = "";
            this.TxtNom.SelectionLength = 0;
            this.TxtNom.SelectionStart = 0;
            this.TxtNom.Size = new System.Drawing.Size(140, 23);
            this.TxtNom.TabIndex = 8;
            this.TxtNom.UseSystemPasswordChar = false;
            // 
            // materialLabel7
            // 
            this.materialLabel7.AutoSize = true;
            this.materialLabel7.Depth = 0;
            this.materialLabel7.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel7.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel7.Location = new System.Drawing.Point(184, 177);
            this.materialLabel7.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel7.Name = "materialLabel7";
            this.materialLabel7.Size = new System.Drawing.Size(42, 19);
            this.materialLabel7.TabIndex = 6;
            this.materialLabel7.Text = "Mail:";
            // 
            // LblTel
            // 
            this.LblTel.AutoSize = true;
            this.LblTel.Depth = 0;
            this.LblTel.Font = new System.Drawing.Font("Roboto", 11F);
            this.LblTel.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.LblTel.Location = new System.Drawing.Point(6, 175);
            this.LblTel.MouseState = MaterialSkin.MouseState.HOVER;
            this.LblTel.Name = "LblTel";
            this.LblTel.Size = new System.Drawing.Size(34, 19);
            this.LblTel.TabIndex = 5;
            this.LblTel.Text = "Tél:";
            // 
            // LblCp
            // 
            this.LblCp.AutoSize = true;
            this.LblCp.Depth = 0;
            this.LblCp.Font = new System.Drawing.Font("Roboto", 11F);
            this.LblCp.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.LblCp.Location = new System.Drawing.Point(6, 139);
            this.LblCp.MouseState = MaterialSkin.MouseState.HOVER;
            this.LblCp.Name = "LblCp";
            this.LblCp.Size = new System.Drawing.Size(32, 19);
            this.LblCp.TabIndex = 4;
            this.LblCp.Text = "CP:";
            // 
            // LblPrenom
            // 
            this.LblPrenom.AutoSize = true;
            this.LblPrenom.Depth = 0;
            this.LblPrenom.Font = new System.Drawing.Font("Roboto", 11F);
            this.LblPrenom.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.LblPrenom.Location = new System.Drawing.Point(240, 32);
            this.LblPrenom.MouseState = MaterialSkin.MouseState.HOVER;
            this.LblPrenom.Name = "LblPrenom";
            this.LblPrenom.Size = new System.Drawing.Size(65, 19);
            this.LblPrenom.TabIndex = 3;
            this.LblPrenom.Text = "Prénom:";
            // 
            // LblAdresse
            // 
            this.LblAdresse.AutoSize = true;
            this.LblAdresse.Depth = 0;
            this.LblAdresse.Font = new System.Drawing.Font("Roboto", 11F);
            this.LblAdresse.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.LblAdresse.Location = new System.Drawing.Point(6, 69);
            this.LblAdresse.MouseState = MaterialSkin.MouseState.HOVER;
            this.LblAdresse.Name = "LblAdresse";
            this.LblAdresse.Size = new System.Drawing.Size(68, 19);
            this.LblAdresse.TabIndex = 2;
            this.LblAdresse.Text = "Adresse:";
            // 
            // LblNom
            // 
            this.LblNom.AutoSize = true;
            this.LblNom.Depth = 0;
            this.LblNom.Font = new System.Drawing.Font("Roboto", 11F);
            this.LblNom.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.LblNom.Location = new System.Drawing.Point(6, 32);
            this.LblNom.MouseState = MaterialSkin.MouseState.HOVER;
            this.LblNom.Name = "LblNom";
            this.LblNom.Size = new System.Drawing.Size(50, 19);
            this.LblNom.TabIndex = 1;
            this.LblNom.Text = "Nom: ";
            // 
            // GpbIdentité
            // 
            this.GpbIdentité.Controls.Add(this.TxtAdresse2);
            this.GpbIdentité.Controls.Add(this.LblNom);
            this.GpbIdentité.Controls.Add(this.TxtNom);
            this.GpbIdentité.Controls.Add(this.LblPrenom);
            this.GpbIdentité.Controls.Add(this.TxtPrenom);
            this.GpbIdentité.Controls.Add(this.LblAdresse);
            this.GpbIdentité.Controls.Add(this.TxtAdresse);
            this.GpbIdentité.Controls.Add(this.TxtMail);
            this.GpbIdentité.Controls.Add(this.TxtTel);
            this.GpbIdentité.Controls.Add(this.materialLabel7);
            this.GpbIdentité.Controls.Add(this.LblCp);
            this.GpbIdentité.Controls.Add(this.TxtCp);
            this.GpbIdentité.Controls.Add(this.LblTel);
            this.GpbIdentité.Controls.Add(this.TxtVille);
            this.GpbIdentité.Controls.Add(this.LblVille);
            this.GpbIdentité.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F);
            this.GpbIdentité.Location = new System.Drawing.Point(7, 116);
            this.GpbIdentité.Name = "GpbIdentité";
            this.GpbIdentité.Size = new System.Drawing.Size(462, 220);
            this.GpbIdentité.TabIndex = 25;
            this.GpbIdentité.TabStop = false;
            this.GpbIdentité.Text = "Identité";
            // 
            // TxtAdresse2
            // 
            this.TxtAdresse2.Depth = 0;
            this.TxtAdresse2.Hint = "";
            this.TxtAdresse2.Location = new System.Drawing.Point(86, 101);
            this.TxtAdresse2.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtAdresse2.Name = "TxtAdresse2";
            this.TxtAdresse2.PasswordChar = '\0';
            this.TxtAdresse2.SelectedText = "";
            this.TxtAdresse2.SelectionLength = 0;
            this.TxtAdresse2.SelectionStart = 0;
            this.TxtAdresse2.Size = new System.Drawing.Size(355, 23);
            this.TxtAdresse2.TabIndex = 16;
            this.TxtAdresse2.UseSystemPasswordChar = false;
            // 
            // BtnEnregistrer
            // 
            this.BtnEnregistrer.AutoSize = true;
            this.BtnEnregistrer.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.BtnEnregistrer.Depth = 0;
            this.BtnEnregistrer.Location = new System.Drawing.Point(20, 345);
            this.BtnEnregistrer.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.BtnEnregistrer.MouseState = MaterialSkin.MouseState.HOVER;
            this.BtnEnregistrer.Name = "BtnEnregistrer";
            this.BtnEnregistrer.Primary = false;
            this.BtnEnregistrer.Size = new System.Drawing.Size(137, 36);
            this.BtnEnregistrer.TabIndex = 26;
            this.BtnEnregistrer.Text = "=> Enregistrer <=";
            this.BtnEnregistrer.UseVisualStyleBackColor = true;
            this.BtnEnregistrer.Click += new System.EventHandler(this.BtnEnregistrer_Click);
            // 
            // materialFlatButton1
            // 
            this.materialFlatButton1.AutoSize = true;
            this.materialFlatButton1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.materialFlatButton1.Depth = 0;
            this.materialFlatButton1.Location = new System.Drawing.Point(18, 390);
            this.materialFlatButton1.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.materialFlatButton1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialFlatButton1.Name = "materialFlatButton1";
            this.materialFlatButton1.Primary = false;
            this.materialFlatButton1.Size = new System.Drawing.Size(141, 36);
            this.materialFlatButton1.TabIndex = 27;
            this.materialFlatButton1.Text = "=> Statistiques <=";
            this.materialFlatButton1.UseVisualStyleBackColor = true;
            this.materialFlatButton1.Click += new System.EventHandler(this.materialFlatButton1_Click);
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = global::MaisonDesLigues.Properties.Resources.logo;
            this.pictureBox2.Location = new System.Drawing.Point(175, 347);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(294, 127);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
            this.pictureBox2.TabIndex = 24;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(55)))), ((int)(((byte)(71)))), ((int)(((byte)(79)))));
            this.pictureBox1.Image = global::MaisonDesLigues.Properties.Resources.mdl_sans_fond_sans_texte;
            this.pictureBox1.Location = new System.Drawing.Point(1083, 30);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(110, 66);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 17;
            this.pictureBox1.TabStop = false;
            // 
            // materialFlatButton2
            // 
            this.materialFlatButton2.AutoSize = true;
            this.materialFlatButton2.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.materialFlatButton2.Depth = 0;
            this.materialFlatButton2.Location = new System.Drawing.Point(39, 435);
            this.materialFlatButton2.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.materialFlatButton2.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialFlatButton2.Name = "materialFlatButton2";
            this.materialFlatButton2.Primary = false;
            this.materialFlatButton2.Size = new System.Drawing.Size(100, 36);
            this.materialFlatButton2.TabIndex = 28;
            this.materialFlatButton2.Text = "=> Ajouts <=";
            this.materialFlatButton2.UseVisualStyleBackColor = true;
            this.materialFlatButton2.Click += new System.EventHandler(this.materialFlatButton2_Click);
            // 
            // FrmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1197, 544);
            this.Controls.Add(this.materialFlatButton2);
            this.Controls.Add(this.materialFlatButton1);
            this.Controls.Add(this.BtnEnregistrer);
            this.Controls.Add(this.GpbIdentité);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.BtnQuitter);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.TabType);
            this.Controls.Add(this.materialTabSelector1);
            this.Name = "FrmMain";
            this.Sizable = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Maison des Ligues";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmMain_FormClosing);
            this.Load += new System.EventHandler(this.FrmMain_Load);
            this.TabType.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.tabPage3.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.GpbIdentité.ResumeLayout(false);
            this.GpbIdentité.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MaterialSkin.Controls.MaterialTabSelector materialTabSelector1;
        private MaterialSkin.Controls.MaterialTabControl TabType;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TabPage tabPage3;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtMail;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtTel;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtVille;
        private MaterialSkin.Controls.MaterialLabel LblVille;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtCp;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtAdresse;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtPrenom;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtNom;
        private MaterialSkin.Controls.MaterialLabel materialLabel7;
        private MaterialSkin.Controls.MaterialLabel LblTel;
        private MaterialSkin.Controls.MaterialLabel LblCp;
        private MaterialSkin.Controls.MaterialLabel LblPrenom;
        private MaterialSkin.Controls.MaterialLabel LblAdresse;
        private MaterialSkin.Controls.MaterialLabel LblNom;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private MaterialSkin.Controls.MaterialRadioButton RdoNuitéNon;
        private MaterialSkin.Controls.MaterialRadioButton RdoNuitéOui;
        private System.Windows.Forms.PictureBox pictureBox2;
        private MaterialSkin.Controls.MaterialSingleLineTextField txtLicence;
        private MaterialSkin.Controls.MaterialLabel materialLabel13;
        private MaterialSkin.Controls.MaterialSingleLineTextField txtNaissance;
        private MaterialSkin.Controls.MaterialLabel materialLabel12;
        private MaterialSkin.Controls.MaterialLabel lblAtelier;
        private System.Windows.Forms.Panel PnlType;
        private System.Windows.Forms.ComboBox CmbAtelier;
        private System.Windows.Forms.Panel panel2;
        private MaterialSkin.Controls.MaterialFlatButton BtnQuitter;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox GpbIdentité;
        private MaterialSkin.Controls.MaterialFlatButton BtnEnregistrer;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Panel PnlNuite;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtAdresse2;
        private MaterialSkin.Controls.MaterialFlatButton materialFlatButton1;
        private MaterialSkin.Controls.MaterialFlatButton materialFlatButton2;
    }
}