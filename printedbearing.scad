// Parametreler
outer_radius = 6;
inner_radius = 4;
height = 3.5;
gap = 0.2;
bump_offset = 0.17;
$fn = 100;

// Ortalamadan hesaplanan yarıçap
mid_radius = ((outer_radius + inner_radius) / 2) - 0.5;

module bumpy_ring(mid_radius, height, gap, bump_offset, flat_top, flat_bottom) {
    difference() {
        // Dış şekil
        rotate_extrude() {
            polygon(points = [
                [mid_radius, 0], 
                [mid_radius + gap, 0],
                [(mid_radius + gap) + (mid_radius / 6), flat_bottom],  // Alt düz kısım
                [(mid_radius + gap) + (mid_radius / 6), height - flat_top],  // Üst düz kısım
                [mid_radius + gap, height],
                [mid_radius, height]
            ],
            paths = [[0, 1, 2, 3, 4, 5, 0]]);
        }

        // İç şekil (aynı bombeyi küçültülmüş ölçülerle oluştur)
        rotate_extrude() {
            polygon(points = [
                [mid_radius - bump_offset, 0], 
                [mid_radius + gap - bump_offset, 0],
                [(mid_radius + gap) + (mid_radius / 6) - bump_offset, flat_bottom],  // Alt düz kısım
                [(mid_radius + gap) + (mid_radius / 6) - bump_offset, height - flat_top],  // Üst düz kısım
                [mid_radius + gap - bump_offset, height],
                [mid_radius - bump_offset, height]
            ],
            paths = [[0, 1, 2, 3, 4, 5, 0]]);
        }
    }
}

// Örnek kullanım



// Difference yapısı ile bumpy_ring çıkarma
difference() {
    // Ana dış silindir
    cylinder(h = height, r = outer_radius, $fn = $fn);

    // İç boşluk
    translate([0, 0, -0.1])
        cylinder(h = height + 2, r = inner_radius, $fn = $fn);

    bumpy_ring(mid_radius, height, gap, bump_offset, flat_top = 0.6, flat_bottom = 0.6);
}
