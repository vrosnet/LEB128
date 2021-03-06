module unpack_u32 (
  input [7:0] i0, i1, i2, i3, i4,
  output logic [31:0] o
);

// i = $.wire()
logic [4:0] gl;
logic [4:0] dc;
logic [6:0] c0, c1, c2, c3, c4;
logic [6:0] k0, k1, k2, k3, k4;

always_comb begin
  // gl = i.msb() // glue bits
  gl[0] = i0[7];
  gl[1] = i1[7];
  gl[2] = i2[7];
  gl[3] = i3[7];
  gl[4] = i4[7];
  // c = i.lsb(7) // chunks
  c0 = i0[6:0];
  c1 = i1[6:0];
  c2 = i2[6:0];
  c3 = i3[6:0];
  c4 = i4[6:0];
  // dc = gl.expand.up()
  dc[0] = gl[0];
  dc[1] = gl[0] | gl[1];
  dc[2] = gl[0] | gl[1] | gl[2];
  dc[3] = gl[0] | gl[1] | gl[2] | gl[3];
  dc[4] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4];
  // k = c.overwrite(dc, 0)
  k0 = dc[0] ? 7'b0 : c0;
  k1 = dc[1] ? 7'b0 : c1;
  k2 = dc[2] ? 7'b0 : c2;
  k3 = dc[3] ? 7'b0 : c3;
  k4 = dc[4] ? 7'b0 : c4;
  // o = k.glue()
  o = {k4, k3, k2, k1, k0};
end

endmodule
