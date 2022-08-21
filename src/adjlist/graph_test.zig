const std = @import("std");
const graph = @import("graph.zig");

const TestError = error{ LeftDidNotEqualRight, CanNotFindNameInGraph, FoundNameInGraphThatDoesNotExist };

// === Tests ===
test "Expect ReadFromFile to initialize Graph w/o error" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var g = try graph.Graph().init(allocator); // take type and just initialize it
    defer g.deinit();
    var g2 = try graph.Graph().init(allocator);
    g2.deinit();
    try g.readFromFile("example_graph.txt");
}

test "Expect FindShortestPath to return shortest path from \"a\" to \"g\" to be 15" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var g = try graph.Graph().init(allocator); // take type and just initialize it
    defer g.deinit();
    try g.readFromFile("example_graph.txt");
    // actual test
    const dist = try g.findShortestPath("a", "f");
    if (dist != 15) return TestError.LeftDidNotEqualRight;
}

test "Expect FindShortestPath to return shortest path from \"f\" to \"d\" to be 17" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var g = try graph.Graph().init(allocator); // take type and just initialize it
    defer g.deinit();
    try g.readFromFile("example_graph.txt");
    // actual test
    const dist = try g.findShortestPath("f", "d");
    if (dist != 17) return TestError.LeftDidNotEqualRight;
}

test "Expect doesNameExistInGraph to return true for \"a\"" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var g = try graph.Graph().init(allocator); // take type and just initialize it
    defer g.deinit();
    try g.readFromFile("example_graph.txt");
    // actual test
    if (!g.doesNameExistInGraph("a")) return TestError.CanNotFindNameInGraph;
}

test "Expect doesNameExistInGraph to return false for \"z\"" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var g = try graph.Graph().init(allocator); // take type and just initialize it
    defer g.deinit();
    try g.readFromFile("example_graph.txt");
    //actual test
    if (g.doesNameExistInGraph("z")) return TestError.FoundNameInGraphThatDoesNotExist;
}