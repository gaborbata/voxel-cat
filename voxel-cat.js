/*
 * voxel-cat
 * js1k-2019 "X" entry
 * @author Gabor Bata
 * @license MIT
 */
{
    let
        // x, y, z dimension for 3D voxel cat data
        C = 20,

        // voxel bitmap width
        W = 20,

        // voxel bitmap height
        H = 21,

        // initial counter for drawing voxel cat slices
        y = C - 1,

        // helper variables
        s, w, x, z,

        // pattern to split color palette and compressed data
        r = /.../g,

        // canvas context
        c = window['a'].getContext`2d`,

        // decompressed data
        // - the first W * H characters are the voxel bitmap
        // - the remaining C * C * C characters are the voxel cat data
        d = [...(
            // substitution map for compressed data
            ' xz!"#"2u#12%yz&7B,66-cs/G>89a9cI:ff;<H<i2=fY>YT@ggAb4B7' +
            'CC76DEFE`eFu`GcQHhZIiMJKLKwzLjqMNONVvOPaPxyQRjRyjS24TUhU' +
            'WXVj_W~gXmvYlrZx2_xi`z2apvb44cdkdkkeppfllgmmhy~iyxjnnkoo' +
            'lrrmprnqqosspuuq33rvvsyttwwu11vyywxxxzzy~~z22~00'
        ).match(r).reduce(
            // decompress data
            (u, b) => u.split(b.charAt(0)).join(b.slice(1)),
            // initial compressed data
            'vahev~ephee~eepzeeqxepn enqwpjJJJJJJJJ~wjh nqv~xnvhzq:fl' +
            'v~A55AvybbbbvyA~A:r;y!h!y!h!os%4Bx4Bz%&x&z%&x&z%,,x,,z~u' +
            'tu~t~utu~tsiVMXZH;;-IXZH;;-Imf-Imf-Q=vyDG=vyDG=vosywS i4' +
            'z42bZiSSSS_2bbA_SS2A_4z42bZywS osQ>t/D/D/t/t8TD8TD8Tt8W@' +
            'g:=@@:=@@:flv'
        )],

        // create voxel bitmaps, with the following colors
        // - 0 dark gray
        // - 1 gray
        // - 2 light gray
        // - 3 white
        // - 4 pink
        // - 5 yellow
        // - 6 black
        v = '99bbbdeefffff9bfd3000'.match(r).map(p => {
            // create offscreen canvas for better performance
            s = document.createElement`canvas`;
            s.width = W;
            s.height = H;
            z = s.getContext`2d`;
            for (w = W * H; w--;) {
                ~~d[w] && [
                    // base color
                    '#' + p,
                    // shadows
                    `rgba(0,0,0,${0.15 * (d[w] - 1)})`
                ].map(n => {
                    z.fillStyle = n;
                    z.fillRect(w % W, 0 | w / W, 1, 1);
                });
            }
            return s;
        });

    // clear canvas with background color
    c.fillStyle = '#7ce';
    c.fillRect(0, 0, 500, 500);

    // draw voxel cat slice by slice
    r = setInterval(() => {
        for (s = C * C; s--;) {
            w = ~~d[C * C * y + s + W * H];
            x = C - 1 - s % C;
            z = C - 1 - (0 | s / C);
            w && c.drawImage(
                v[w - 1],
                60 + x * 10 + y * 10,
                335 + x * 5 - y * 5 - z * 12
            );
        }
        !y-- && clearInterval(r);
    }, 500);
}
