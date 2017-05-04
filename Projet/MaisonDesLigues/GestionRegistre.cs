using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Win32;

namespace MaisonDesLigues.Utilitaires
{
    internal abstract class GestionRegistre
    {
        private static RegistryKey rk = Registry.CurrentUser.CreateSubKey(@"M2L\", RegistryKeyPermissionCheck.Default);
        private const string CURRENT_MDP = "MDL_Current_Mdp";

        public static void CreerSauvegardeMdp()
        {
            rk.SetValue(CURRENT_MDP, @"monMDPdeOUF");
        }

        public static void SupprimerSauvegardeMdp()
        {
            rk.DeleteValue(CURRENT_MDP);
        }


    }
}
