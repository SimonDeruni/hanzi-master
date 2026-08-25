import 'dart:math';

class DtwAligner {
  /// Aligns the user pitch array to the reference pitch array using Dynamic Time Warping.
  /// Returns a new array of the same length as [reference], containing the user's pitch values stretched/compressed to match.
  static List<double?> alignPitch(List<double?> reference, List<double?> user) {
    if (reference.isEmpty) return [];
    if (user.isEmpty) return List.filled(reference.length, null);

    // Filter out nulls for alignment calculation, but keep original indices
    final refValid = <MapEntry<int, double>>[];
    for (int i = 0; i < reference.length; i++) {
      if (reference[i] != null) refValid.add(MapEntry(i, reference[i]!));
    }
    
    final userValid = <MapEntry<int, double>>[];
    for (int i = 0; i < user.length; i++) {
      if (user[i] != null) userValid.add(MapEntry(i, user[i]!));
    }

    if (refValid.isEmpty || userValid.isEmpty) return List.filled(reference.length, null);

    int n = refValid.length;
    int m = userValid.length;
    
    List<List<double>> dtw = List.generate(n + 1, (_) => List.filled(m + 1, double.infinity));
    dtw[0][0] = 0;

    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= m; j++) {
        double cost = (refValid[i - 1].value - userValid[j - 1].value).abs();
        dtw[i][j] = cost + min(dtw[i - 1][j], min(dtw[i][j - 1], dtw[i - 1][j - 1]));
      }
    }

    // Backtrack to find the optimal path
    int i = n;
    int j = m;
    List<MapEntry<int, int>> path = [];
    while (i > 0 && j > 0) {
      path.add(MapEntry(i - 1, j - 1));
      if (dtw[i - 1][j - 1] <= dtw[i - 1][j] && dtw[i - 1][j - 1] <= dtw[i][j - 1]) {
        i--;
        j--;
      } else if (dtw[i - 1][j] <= dtw[i][j - 1]) {
        i--;
      } else {
        j--;
      }
    }
    path = path.reversed.toList();

    // Reconstruct the aligned user array mapped to the reference array size
    List<double?> alignedUser = List.filled(reference.length, null);
    for (var p in path) {
      int refIndex = refValid[p.key].key;
      alignedUser[refIndex] = userValid[p.value].value;
    }

    return alignedUser;
  }
}
