namespace MaisonDesLigues
{
    partial class FrmAdd
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
            this.materialTabControl1 = new MaterialSkin.Controls.MaterialTabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.materialLabel2 = new MaterialSkin.Controls.MaterialLabel();
            this.materialSingleLineTextField_nbPlaceAtelier = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.materialLabel1 = new MaterialSkin.Controls.MaterialLabel();
            this.btn_ajouterAtelier = new MaterialSkin.Controls.MaterialFlatButton();
            this.materialSingleLineTextField_libelle_atelier = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.materialFlatButton_AjouterTheme = new MaterialSkin.Controls.MaterialFlatButton();
            this.comboBox_Ateliers = new System.Windows.Forms.ComboBox();
            this.materialLabel4 = new MaterialSkin.Controls.MaterialLabel();
            this.materialLabel3 = new MaterialSkin.Controls.MaterialLabel();
            this.materialSingleLineTextField_LibelleTheme = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.materialFlatButton_AjouterVacations = new MaterialSkin.Controls.MaterialFlatButton();
            this.materialLabel7 = new MaterialSkin.Controls.MaterialLabel();
            this.maskedTextBox_HeureFin = new System.Windows.Forms.MaskedTextBox();
            this.materialLabel6 = new MaterialSkin.Controls.MaterialLabel();
            this.maskedTextBox_HeureDebut = new System.Windows.Forms.MaskedTextBox();
            this.comboBox_Atelier_Vacations = new System.Windows.Forms.ComboBox();
            this.materialLabel5 = new MaterialSkin.Controls.MaterialLabel();
            this.tabPage4 = new System.Windows.Forms.TabPage();
            this.materialFlatButton_modifier = new MaterialSkin.Controls.MaterialFlatButton();
            this.materialLabel8 = new MaterialSkin.Controls.MaterialLabel();
            this.maskedTextBox_HeureFinModifier = new System.Windows.Forms.MaskedTextBox();
            this.materialLabel9 = new MaterialSkin.Controls.MaterialLabel();
            this.maskedTextBox_heureDebutModifier = new System.Windows.Forms.MaskedTextBox();
            this.comboBox_Vacations = new System.Windows.Forms.ComboBox();
            this.materialLabel10 = new MaterialSkin.Controls.MaterialLabel();
            this.materialTabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.tabPage4.SuspendLayout();
            this.SuspendLayout();
            // 
            // materialTabSelector1
            // 
            this.materialTabSelector1.BaseTabControl = this.materialTabControl1;
            this.materialTabSelector1.Depth = 0;
            this.materialTabSelector1.Location = new System.Drawing.Point(0, 64);
            this.materialTabSelector1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabSelector1.Name = "materialTabSelector1";
            this.materialTabSelector1.Size = new System.Drawing.Size(536, 23);
            this.materialTabSelector1.TabIndex = 4;
            this.materialTabSelector1.Text = "materialTabSelector1";
            // 
            // materialTabControl1
            // 
            this.materialTabControl1.Controls.Add(this.tabPage1);
            this.materialTabControl1.Controls.Add(this.tabPage2);
            this.materialTabControl1.Controls.Add(this.tabPage3);
            this.materialTabControl1.Controls.Add(this.tabPage4);
            this.materialTabControl1.Depth = 0;
            this.materialTabControl1.Location = new System.Drawing.Point(8, 90);
            this.materialTabControl1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialTabControl1.Name = "materialTabControl1";
            this.materialTabControl1.SelectedIndex = 0;
            this.materialTabControl1.Size = new System.Drawing.Size(514, 159);
            this.materialTabControl1.TabIndex = 5;
            // 
            // tabPage1
            // 
            this.tabPage1.BackColor = System.Drawing.Color.White;
            this.tabPage1.Controls.Add(this.materialLabel2);
            this.tabPage1.Controls.Add(this.materialSingleLineTextField_nbPlaceAtelier);
            this.tabPage1.Controls.Add(this.materialLabel1);
            this.tabPage1.Controls.Add(this.btn_ajouterAtelier);
            this.tabPage1.Controls.Add(this.materialSingleLineTextField_libelle_atelier);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(506, 133);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Ateliers";
            // 
            // materialLabel2
            // 
            this.materialLabel2.AutoSize = true;
            this.materialLabel2.Depth = 0;
            this.materialLabel2.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel2.Location = new System.Drawing.Point(11, 59);
            this.materialLabel2.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel2.Name = "materialLabel2";
            this.materialLabel2.Size = new System.Drawing.Size(131, 19);
            this.materialLabel2.TabIndex = 10;
            this.materialLabel2.Text = "Nombre de place :";
            // 
            // materialSingleLineTextField_nbPlaceAtelier
            // 
            this.materialSingleLineTextField_nbPlaceAtelier.Depth = 0;
            this.materialSingleLineTextField_nbPlaceAtelier.Hint = "";
            this.materialSingleLineTextField_nbPlaceAtelier.Location = new System.Drawing.Point(147, 59);
            this.materialSingleLineTextField_nbPlaceAtelier.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialSingleLineTextField_nbPlaceAtelier.Name = "materialSingleLineTextField_nbPlaceAtelier";
            this.materialSingleLineTextField_nbPlaceAtelier.PasswordChar = '\0';
            this.materialSingleLineTextField_nbPlaceAtelier.SelectedText = "";
            this.materialSingleLineTextField_nbPlaceAtelier.SelectionLength = 0;
            this.materialSingleLineTextField_nbPlaceAtelier.SelectionStart = 0;
            this.materialSingleLineTextField_nbPlaceAtelier.Size = new System.Drawing.Size(48, 23);
            this.materialSingleLineTextField_nbPlaceAtelier.TabIndex = 9;
            this.materialSingleLineTextField_nbPlaceAtelier.UseSystemPasswordChar = false;
            this.materialSingleLineTextField_nbPlaceAtelier.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.materialSingleLineTextField1_KeyPress);
            // 
            // materialLabel1
            // 
            this.materialLabel1.AutoSize = true;
            this.materialLabel1.Depth = 0;
            this.materialLabel1.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel1.Location = new System.Drawing.Point(11, 15);
            this.materialLabel1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel1.Name = "materialLabel1";
            this.materialLabel1.Size = new System.Drawing.Size(61, 19);
            this.materialLabel1.TabIndex = 8;
            this.materialLabel1.Text = "Libellé :";
            // 
            // btn_ajouterAtelier
            // 
            this.btn_ajouterAtelier.AutoSize = true;
            this.btn_ajouterAtelier.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.btn_ajouterAtelier.BackColor = System.Drawing.SystemColors.Control;
            this.btn_ajouterAtelier.Depth = 0;
            this.btn_ajouterAtelier.Location = new System.Drawing.Point(304, 51);
            this.btn_ajouterAtelier.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.btn_ajouterAtelier.MouseState = MaterialSkin.MouseState.HOVER;
            this.btn_ajouterAtelier.Name = "btn_ajouterAtelier";
            this.btn_ajouterAtelier.Primary = false;
            this.btn_ajouterAtelier.Size = new System.Drawing.Size(72, 36);
            this.btn_ajouterAtelier.TabIndex = 7;
            this.btn_ajouterAtelier.Text = "Ajouter";
            this.btn_ajouterAtelier.UseVisualStyleBackColor = false;
            this.btn_ajouterAtelier.Click += new System.EventHandler(this.btn_ajouterAtelier_Click);
            // 
            // materialSingleLineTextField_libelle_atelier
            // 
            this.materialSingleLineTextField_libelle_atelier.BackColor = System.Drawing.SystemColors.Control;
            this.materialSingleLineTextField_libelle_atelier.Depth = 0;
            this.materialSingleLineTextField_libelle_atelier.Hint = "";
            this.materialSingleLineTextField_libelle_atelier.Location = new System.Drawing.Point(76, 13);
            this.materialSingleLineTextField_libelle_atelier.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialSingleLineTextField_libelle_atelier.Name = "materialSingleLineTextField_libelle_atelier";
            this.materialSingleLineTextField_libelle_atelier.PasswordChar = '\0';
            this.materialSingleLineTextField_libelle_atelier.SelectedText = "";
            this.materialSingleLineTextField_libelle_atelier.SelectionLength = 0;
            this.materialSingleLineTextField_libelle_atelier.SelectionStart = 0;
            this.materialSingleLineTextField_libelle_atelier.Size = new System.Drawing.Size(300, 23);
            this.materialSingleLineTextField_libelle_atelier.TabIndex = 0;
            this.materialSingleLineTextField_libelle_atelier.UseSystemPasswordChar = false;
            // 
            // tabPage2
            // 
            this.tabPage2.BackColor = System.Drawing.Color.White;
            this.tabPage2.Controls.Add(this.materialFlatButton_AjouterTheme);
            this.tabPage2.Controls.Add(this.comboBox_Ateliers);
            this.tabPage2.Controls.Add(this.materialLabel4);
            this.tabPage2.Controls.Add(this.materialLabel3);
            this.tabPage2.Controls.Add(this.materialSingleLineTextField_LibelleTheme);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(506, 133);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Themes";
            // 
            // materialFlatButton_AjouterTheme
            // 
            this.materialFlatButton_AjouterTheme.AutoSize = true;
            this.materialFlatButton_AjouterTheme.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.materialFlatButton_AjouterTheme.BackColor = System.Drawing.SystemColors.Control;
            this.materialFlatButton_AjouterTheme.Depth = 0;
            this.materialFlatButton_AjouterTheme.Location = new System.Drawing.Point(304, 51);
            this.materialFlatButton_AjouterTheme.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.materialFlatButton_AjouterTheme.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialFlatButton_AjouterTheme.Name = "materialFlatButton_AjouterTheme";
            this.materialFlatButton_AjouterTheme.Primary = false;
            this.materialFlatButton_AjouterTheme.Size = new System.Drawing.Size(72, 36);
            this.materialFlatButton_AjouterTheme.TabIndex = 13;
            this.materialFlatButton_AjouterTheme.Text = "Ajouter";
            this.materialFlatButton_AjouterTheme.UseVisualStyleBackColor = false;
            // 
            // comboBox_Ateliers
            // 
            this.comboBox_Ateliers.FormattingEnabled = true;
            this.comboBox_Ateliers.Location = new System.Drawing.Point(78, 60);
            this.comboBox_Ateliers.Name = "comboBox_Ateliers";
            this.comboBox_Ateliers.Size = new System.Drawing.Size(194, 21);
            this.comboBox_Ateliers.TabIndex = 12;
            // 
            // materialLabel4
            // 
            this.materialLabel4.AutoSize = true;
            this.materialLabel4.Depth = 0;
            this.materialLabel4.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel4.Location = new System.Drawing.Point(11, 59);
            this.materialLabel4.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel4.Name = "materialLabel4";
            this.materialLabel4.Size = new System.Drawing.Size(61, 19);
            this.materialLabel4.TabIndex = 11;
            this.materialLabel4.Text = "Atelier :";
            // 
            // materialLabel3
            // 
            this.materialLabel3.AutoSize = true;
            this.materialLabel3.Depth = 0;
            this.materialLabel3.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel3.Location = new System.Drawing.Point(11, 15);
            this.materialLabel3.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel3.Name = "materialLabel3";
            this.materialLabel3.Size = new System.Drawing.Size(61, 19);
            this.materialLabel3.TabIndex = 10;
            this.materialLabel3.Text = "Libellé :";
            // 
            // materialSingleLineTextField_LibelleTheme
            // 
            this.materialSingleLineTextField_LibelleTheme.BackColor = System.Drawing.SystemColors.Control;
            this.materialSingleLineTextField_LibelleTheme.Depth = 0;
            this.materialSingleLineTextField_LibelleTheme.Hint = "";
            this.materialSingleLineTextField_LibelleTheme.Location = new System.Drawing.Point(76, 13);
            this.materialSingleLineTextField_LibelleTheme.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialSingleLineTextField_LibelleTheme.Name = "materialSingleLineTextField_LibelleTheme";
            this.materialSingleLineTextField_LibelleTheme.PasswordChar = '\0';
            this.materialSingleLineTextField_LibelleTheme.SelectedText = "";
            this.materialSingleLineTextField_LibelleTheme.SelectionLength = 0;
            this.materialSingleLineTextField_LibelleTheme.SelectionStart = 0;
            this.materialSingleLineTextField_LibelleTheme.Size = new System.Drawing.Size(300, 23);
            this.materialSingleLineTextField_LibelleTheme.TabIndex = 9;
            this.materialSingleLineTextField_LibelleTheme.UseSystemPasswordChar = false;
            // 
            // tabPage3
            // 
            this.tabPage3.BackColor = System.Drawing.Color.White;
            this.tabPage3.Controls.Add(this.materialFlatButton_AjouterVacations);
            this.tabPage3.Controls.Add(this.materialLabel7);
            this.tabPage3.Controls.Add(this.maskedTextBox_HeureFin);
            this.tabPage3.Controls.Add(this.materialLabel6);
            this.tabPage3.Controls.Add(this.maskedTextBox_HeureDebut);
            this.tabPage3.Controls.Add(this.comboBox_Atelier_Vacations);
            this.tabPage3.Controls.Add(this.materialLabel5);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(506, 133);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Vacations";
            // 
            // materialFlatButton_AjouterVacations
            // 
            this.materialFlatButton_AjouterVacations.AutoSize = true;
            this.materialFlatButton_AjouterVacations.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.materialFlatButton_AjouterVacations.BackColor = System.Drawing.SystemColors.Control;
            this.materialFlatButton_AjouterVacations.Depth = 0;
            this.materialFlatButton_AjouterVacations.Location = new System.Drawing.Point(201, 73);
            this.materialFlatButton_AjouterVacations.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.materialFlatButton_AjouterVacations.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialFlatButton_AjouterVacations.Name = "materialFlatButton_AjouterVacations";
            this.materialFlatButton_AjouterVacations.Primary = false;
            this.materialFlatButton_AjouterVacations.Size = new System.Drawing.Size(72, 36);
            this.materialFlatButton_AjouterVacations.TabIndex = 19;
            this.materialFlatButton_AjouterVacations.Text = "Ajouter";
            this.materialFlatButton_AjouterVacations.UseVisualStyleBackColor = false;
            // 
            // materialLabel7
            // 
            this.materialLabel7.AutoSize = true;
            this.materialLabel7.Depth = 0;
            this.materialLabel7.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel7.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel7.Location = new System.Drawing.Point(12, 88);
            this.materialLabel7.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel7.Name = "materialLabel7";
            this.materialLabel7.Size = new System.Drawing.Size(78, 19);
            this.materialLabel7.TabIndex = 18;
            this.materialLabel7.Text = "Heure fin :";
            // 
            // maskedTextBox_HeureFin
            // 
            this.maskedTextBox_HeureFin.Location = new System.Drawing.Point(116, 89);
            this.maskedTextBox_HeureFin.Mask = "00:00";
            this.maskedTextBox_HeureFin.Name = "maskedTextBox_HeureFin";
            this.maskedTextBox_HeureFin.PromptChar = '0';
            this.maskedTextBox_HeureFin.Size = new System.Drawing.Size(52, 20);
            this.maskedTextBox_HeureFin.TabIndex = 17;
            this.maskedTextBox_HeureFin.ValidatingType = typeof(System.DateTime);
            // 
            // materialLabel6
            // 
            this.materialLabel6.AutoSize = true;
            this.materialLabel6.Depth = 0;
            this.materialLabel6.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel6.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel6.Location = new System.Drawing.Point(12, 50);
            this.materialLabel6.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel6.Name = "materialLabel6";
            this.materialLabel6.Size = new System.Drawing.Size(98, 19);
            this.materialLabel6.TabIndex = 16;
            this.materialLabel6.Text = "Heure début :";
            // 
            // maskedTextBox_HeureDebut
            // 
            this.maskedTextBox_HeureDebut.Location = new System.Drawing.Point(116, 51);
            this.maskedTextBox_HeureDebut.Mask = "00:00";
            this.maskedTextBox_HeureDebut.Name = "maskedTextBox_HeureDebut";
            this.maskedTextBox_HeureDebut.PromptChar = '0';
            this.maskedTextBox_HeureDebut.Size = new System.Drawing.Size(52, 20);
            this.maskedTextBox_HeureDebut.TabIndex = 15;
            this.maskedTextBox_HeureDebut.ValidatingType = typeof(System.DateTime);
            // 
            // comboBox_Atelier_Vacations
            // 
            this.comboBox_Atelier_Vacations.FormattingEnabled = true;
            this.comboBox_Atelier_Vacations.Location = new System.Drawing.Point(79, 14);
            this.comboBox_Atelier_Vacations.Name = "comboBox_Atelier_Vacations";
            this.comboBox_Atelier_Vacations.Size = new System.Drawing.Size(194, 21);
            this.comboBox_Atelier_Vacations.TabIndex = 14;
            // 
            // materialLabel5
            // 
            this.materialLabel5.AutoSize = true;
            this.materialLabel5.Depth = 0;
            this.materialLabel5.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel5.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel5.Location = new System.Drawing.Point(12, 13);
            this.materialLabel5.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel5.Name = "materialLabel5";
            this.materialLabel5.Size = new System.Drawing.Size(61, 19);
            this.materialLabel5.TabIndex = 13;
            this.materialLabel5.Text = "Atelier :";
            // 
            // tabPage4
            // 
            this.tabPage4.BackColor = System.Drawing.Color.White;
            this.tabPage4.Controls.Add(this.materialFlatButton_modifier);
            this.tabPage4.Controls.Add(this.materialLabel8);
            this.tabPage4.Controls.Add(this.maskedTextBox_HeureFinModifier);
            this.tabPage4.Controls.Add(this.materialLabel9);
            this.tabPage4.Controls.Add(this.maskedTextBox_heureDebutModifier);
            this.tabPage4.Controls.Add(this.comboBox_Vacations);
            this.tabPage4.Controls.Add(this.materialLabel10);
            this.tabPage4.Location = new System.Drawing.Point(4, 22);
            this.tabPage4.Name = "tabPage4";
            this.tabPage4.Size = new System.Drawing.Size(506, 133);
            this.tabPage4.TabIndex = 3;
            this.tabPage4.Text = "Modifications";
            // 
            // materialFlatButton_modifier
            // 
            this.materialFlatButton_modifier.AutoSize = true;
            this.materialFlatButton_modifier.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.materialFlatButton_modifier.BackColor = System.Drawing.SystemColors.Control;
            this.materialFlatButton_modifier.Depth = 0;
            this.materialFlatButton_modifier.Location = new System.Drawing.Point(201, 73);
            this.materialFlatButton_modifier.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.materialFlatButton_modifier.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialFlatButton_modifier.Name = "materialFlatButton_modifier";
            this.materialFlatButton_modifier.Primary = false;
            this.materialFlatButton_modifier.Size = new System.Drawing.Size(74, 36);
            this.materialFlatButton_modifier.TabIndex = 26;
            this.materialFlatButton_modifier.Text = "Modifier";
            this.materialFlatButton_modifier.UseVisualStyleBackColor = false;
            // 
            // materialLabel8
            // 
            this.materialLabel8.AutoSize = true;
            this.materialLabel8.Depth = 0;
            this.materialLabel8.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel8.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel8.Location = new System.Drawing.Point(12, 88);
            this.materialLabel8.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel8.Name = "materialLabel8";
            this.materialLabel8.Size = new System.Drawing.Size(78, 19);
            this.materialLabel8.TabIndex = 25;
            this.materialLabel8.Text = "Heure fin :";
            // 
            // maskedTextBox_HeureFinModifier
            // 
            this.maskedTextBox_HeureFinModifier.Location = new System.Drawing.Point(116, 89);
            this.maskedTextBox_HeureFinModifier.Mask = "00:00";
            this.maskedTextBox_HeureFinModifier.Name = "maskedTextBox_HeureFinModifier";
            this.maskedTextBox_HeureFinModifier.PromptChar = '0';
            this.maskedTextBox_HeureFinModifier.Size = new System.Drawing.Size(52, 20);
            this.maskedTextBox_HeureFinModifier.TabIndex = 24;
            this.maskedTextBox_HeureFinModifier.ValidatingType = typeof(System.DateTime);
            // 
            // materialLabel9
            // 
            this.materialLabel9.AutoSize = true;
            this.materialLabel9.Depth = 0;
            this.materialLabel9.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel9.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel9.Location = new System.Drawing.Point(12, 50);
            this.materialLabel9.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel9.Name = "materialLabel9";
            this.materialLabel9.Size = new System.Drawing.Size(98, 19);
            this.materialLabel9.TabIndex = 23;
            this.materialLabel9.Text = "Heure début :";
            // 
            // maskedTextBox_heureDebutModifier
            // 
            this.maskedTextBox_heureDebutModifier.Location = new System.Drawing.Point(116, 51);
            this.maskedTextBox_heureDebutModifier.Mask = "00:00";
            this.maskedTextBox_heureDebutModifier.Name = "maskedTextBox_heureDebutModifier";
            this.maskedTextBox_heureDebutModifier.PromptChar = '0';
            this.maskedTextBox_heureDebutModifier.Size = new System.Drawing.Size(52, 20);
            this.maskedTextBox_heureDebutModifier.TabIndex = 22;
            this.maskedTextBox_heureDebutModifier.ValidatingType = typeof(System.DateTime);
            // 
            // comboBox_Vacations
            // 
            this.comboBox_Vacations.FormattingEnabled = true;
            this.comboBox_Vacations.Location = new System.Drawing.Point(79, 14);
            this.comboBox_Vacations.Name = "comboBox_Vacations";
            this.comboBox_Vacations.Size = new System.Drawing.Size(194, 21);
            this.comboBox_Vacations.TabIndex = 21;
            // 
            // materialLabel10
            // 
            this.materialLabel10.AutoSize = true;
            this.materialLabel10.Depth = 0;
            this.materialLabel10.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel10.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel10.Location = new System.Drawing.Point(12, 13);
            this.materialLabel10.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel10.Name = "materialLabel10";
            this.materialLabel10.Size = new System.Drawing.Size(77, 19);
            this.materialLabel10.TabIndex = 20;
            this.materialLabel10.Text = "Vacation :";
            // 
            // FrmAdd
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(524, 257);
            this.Controls.Add(this.materialTabSelector1);
            this.Controls.Add(this.materialTabControl1);
            this.Name = "FrmAdd";
            this.Sizable = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Application Assises de l\'Escrime";
            this.Load += new System.EventHandler(this.FrmAdd_Load);
            this.materialTabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            this.tabPage3.ResumeLayout(false);
            this.tabPage3.PerformLayout();
            this.tabPage4.ResumeLayout(false);
            this.tabPage4.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private MaterialSkin.Controls.MaterialTabSelector materialTabSelector1;
        private MaterialSkin.Controls.MaterialTabControl materialTabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TabPage tabPage3;
        private MaterialSkin.Controls.MaterialSingleLineTextField materialSingleLineTextField_libelle_atelier;
        private MaterialSkin.Controls.MaterialFlatButton btn_ajouterAtelier;
        private MaterialSkin.Controls.MaterialLabel materialLabel1;
        private MaterialSkin.Controls.MaterialSingleLineTextField materialSingleLineTextField_nbPlaceAtelier;
        private MaterialSkin.Controls.MaterialLabel materialLabel2;
        private MaterialSkin.Controls.MaterialFlatButton materialFlatButton_AjouterTheme;
        private System.Windows.Forms.ComboBox comboBox_Ateliers;
        private MaterialSkin.Controls.MaterialLabel materialLabel4;
        private MaterialSkin.Controls.MaterialLabel materialLabel3;
        private MaterialSkin.Controls.MaterialSingleLineTextField materialSingleLineTextField_LibelleTheme;
        private System.Windows.Forms.ComboBox comboBox_Atelier_Vacations;
        private MaterialSkin.Controls.MaterialLabel materialLabel5;
        private System.Windows.Forms.MaskedTextBox maskedTextBox_HeureDebut;
        private MaterialSkin.Controls.MaterialFlatButton materialFlatButton_AjouterVacations;
        private MaterialSkin.Controls.MaterialLabel materialLabel7;
        private System.Windows.Forms.MaskedTextBox maskedTextBox_HeureFin;
        private MaterialSkin.Controls.MaterialLabel materialLabel6;
        private System.Windows.Forms.TabPage tabPage4;
        private MaterialSkin.Controls.MaterialFlatButton materialFlatButton_modifier;
        private MaterialSkin.Controls.MaterialLabel materialLabel8;
        private System.Windows.Forms.MaskedTextBox maskedTextBox_HeureFinModifier;
        private MaterialSkin.Controls.MaterialLabel materialLabel9;
        private System.Windows.Forms.MaskedTextBox maskedTextBox_heureDebutModifier;
        private System.Windows.Forms.ComboBox comboBox_Vacations;
        private MaterialSkin.Controls.MaterialLabel materialLabel10;
    }
}