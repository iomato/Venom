/*
 *    This file is part of Venom.
 *
 *    Venom is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    Venom is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with Venom.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Venom {
  public class Tools {
    // find our data dir (on linux most likely /usr/share or /usr/local/share)
    public static string find_data_dir() {
      foreach (string s in GLib.Environment.get_system_data_dirs()) {
        string dir = Path.build_filename(s, "venom");
        File f = File.new_for_path(dir);
        if(f.query_exists())
          return dir;
      }
      return "";
    }

    // convert a hexstring to uint8[]
    public static uint8[] hexstring_to_bin(string s) {
      uint8[] buf = new uint8[s.length / 2];
      for(int i = 0; i < buf.length; ++i) {
        int b = 0;
        s.substring(2*i, 2).scanf("%02x", ref b);
        buf[i] = (uint8)b;
      }
      return buf;
    }

    // convert a uint8[] to string
    public static string bin_to_hexstring(uint8[] bin) {
      if(bin == null || bin.length == 0)
        return "";
      StringBuilder b = new StringBuilder();
      for(int i = 0; i < bin.length; ++i) {
        b.append("%02X".printf(bin[i]));
      }
      return b.str;
    }

    // convert a string to a nullterminated uint8[]
    public static uint8[] string_to_nullterm_uint (string input){
      if(input == null || input.length <= 0)
        return {'\0'};
      uint8[] clone = new uint8[input.data.length + 1];
      Memory.copy(clone, input.data, input.data.length * sizeof(uint8));
      clone[clone.length - 1] = '\0';
      return clone;
    }

    // clone the given array
    public static uint8[] clone(uint8[] input, int length) {
      uint8[] clone = new uint8[length];
      Memory.copy(clone, input, length * sizeof(uint8));
      return clone;
    }
  }
}