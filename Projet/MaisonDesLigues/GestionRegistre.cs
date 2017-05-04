using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Win32;

namespace MaisonDesLigues.Utilitaires
{
    internal static class GestionRegistre
    {
        private static RegistryKey rklogin = Registry.CurrentUser.CreateSubKey(@"M2L\", RegistryKeyPermissionCheck.ReadWriteSubTree);
        private static RegistryKey rkmdp = Registry.CurrentUser.CreateSubKey(@"M2L\", RegistryKeyPermissionCheck.ReadWriteSubTree);
        private static RegistryKey rkcle = Registry.CurrentUser.CreateSubKey(@"M2L\", RegistryKeyPermissionCheck.ReadWriteSubTree);


        public static void CreerSauvegardeMdp(string compte, string mdp)
        {
            if (!VerifierCle())
            {
                rklogin.SetValue("log", compte);
                string key = Utilitaire.GenererAleatoire(64);
                rkcle.SetValue("key", key);
                rkmdp.SetValue("pass", RC4(mdp, key));
            }
            
        }

        public static void SupprimerSauvegardeMdp()
        {
            try
            {
                rklogin.DeleteValue("log");
                rkcle.DeleteValue("key");
                rkmdp.DeleteValue("pass");
            }
            catch (Exception)
            {

            }
        }

        public static bool VerifierCle()
        {
            if (!(rklogin.GetValue("log") == null ||
                  rkcle.GetValue("key") == null ||
                  rkmdp.GetValue("pass") == null))
            {
                return true;
            }
            return false;
        }

        public static string GetLogin()
        {
            return rklogin.GetValue("log").ToString();
        }

        public static string GetKey()
        {
            return rkcle.GetValue("cle").ToString();
        }

        public static string GetPass()
        {
            return RC4(rkmdp.GetValue("pass").ToString(), rkmdp.GetValue("key").ToString());
        }


        public static string RC4(string input, string key)
        {
            StringBuilder result = new StringBuilder();
            int x, y, j = 0;
            int[] box = new int[256];

            for (int i = 0; i < 256; i++)
            {
                box[i] = i;
            }

            for (int i = 0; i < 256; i++)
            {
                j = (key[i % key.Length] + box[i] + j) % 256;
                x = box[i];
                box[i] = box[j];
                box[j] = x;
            }

            for (int i = 0; i < input.Length; i++)
            {
                y = i % 256;
                j = (box[y] + j) % 256;
                x = box[y];
                box[y] = box[j];
                box[j] = x;

                result.Append((char)(input[i] ^ box[(box[y] + box[j]) % 256]));
            }
            return result.ToString();
        }

        /*
            Results to º§(ÓM¦Kéµ(äþ«
            string cypheredText = RC4("fluxbytes.com", "mykey");
 
            // Results to fluxbytes.com
            string deCypheredText = RC4(cypheredText, "mykey");
        */


    }
}
